import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mandar_trip/api.dart';
import '../../../shared/shared_value.dart';

const double CAMERAZOOM = 18;
const double CAMERATILT = 80;
const double CAMERABEARING = 30;
const double PIN_INVISIBLE_POSITION = -200;
const double PIN_VISIBLE_POSITION = 20;

class Direction extends StatefulWidget {
  const Direction({Key? key}) : super(key: key);

  @override
  State<Direction> createState() => _DirectionState();
}

class _DirectionState extends State<Direction> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _gmapController;
  final Map<String, dynamic> tour = Get.arguments;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String userID = auth.currentUser!.uid;
    yield* firestore.collection('users').doc(userID).snapshots();
  }

  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  double _pinPosition = PIN_VISIBLE_POSITION;
  late String mapStyle;

  @override
  void initState() {
    super.initState();
    getCurrenLocation();
    costumMarkerIcon();
    rootBundle.loadString('assets/map/mapstyle.txt').then((string) {
      mapStyle = string;
    });
  }

  LocationData? currentLocation;
  void getCurrenLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    // final GoogleMapController _cameraLive = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        // _cameraLive.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(newLoc.latitude!, newLoc.longitude!))));
        setState(() {});
      },
    );
  }

  // ? Costum Marker
  BitmapDescriptor _origin = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _currentLoc = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _destination = BitmapDescriptor.defaultMarker;

  void costumMarkerIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/icons/mark_currentloc.png").then((_curr) {
      _currentLoc = _curr;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/icons/origin.png").then((_orig) {
      _origin = _orig;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/icons/marker_tour.png").then((_des) {
      _destination = _des;
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller;
    currentLocation;
    getCurrenLocation();
  }

  @override
  Widget build(BuildContext context) {
    // print("MY LOCATION $currentLocation");
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 9, top: 9, bottom: 9),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: grey.withAlpha(130),
            ),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset(arrowLeft, color: theme.iconTheme.color),
            ),
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: streamUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;
            // Draw polyline
            void getPolyline() async {
              PolylinePoints polylinePoints = PolylinePoints();
              PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
                directionApi,
                PointLatLng(user["position"]["lat"], user["position"]["long"]),
                PointLatLng(tour["position"]["lat"], tour["position"]["long"]),
                travelMode: TravelMode.driving,
              );
              if (result.points.isNotEmpty) {
                for (var point in result.points) {
                  polylineCoordinates.add(
                    LatLng(point.latitude, point.longitude),
                  );
                  setState(() {});
                }
              }
              setState(() {});
            }

            return currentLocation == null
                ? Center(
                    child: AvatarGlow(
                      child: Text("PLEASE WAIT", style: theme.textTheme.bodyText1),
                      endRadius: 80,
                      duration: const Duration(seconds: 2),
                      glowColor: red,
                      showTwoGlows: true,
                    ),
                  )
                : Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(user["position"]["lat"], user["position"]["long"]),
                          zoom: CAMERAZOOM,
                          bearing: CAMERABEARING,
                          tilt: CAMERATILT,
                        ),
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        zoomGesturesEnabled: true,
                        mapToolbarEnabled: false,
                        compassEnabled: false,
                        liteModeEnabled: false,
                        onMapCreated: (controller) {
                          _gmapController = controller;
                          _controller.complete(controller);
                          getPolyline();
                          _gmapController!.setMapStyle(mapStyle);
                        },
                        onTap: (LatLng loc) {
                          setState(() {
                            _pinPosition = PIN_INVISIBLE_POSITION;
                          });
                        },
                        polylines: {
                          Polyline(
                            polylineId: const PolylineId("Poly"),
                            points: polylineCoordinates,
                            color: Colors.red,
                            width: 8,
                          ),
                        },
                        markers: {
                          Marker(
                            markerId: const MarkerId("Destination"),
                            position: LatLng(tour["position"]["lat"], tour["position"]["long"]),
                            icon: _destination,
                            onTap: () {
                              _gmapController!.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(tour["position"]["lat"], tour["position"]["long"]),
                                    zoom: CAMERAZOOM,
                                    bearing: CAMERABEARING,
                                    tilt: CAMERATILT,
                                  ),
                                ),
                              );
                              setState(() {
                                _pinPosition = PIN_VISIBLE_POSITION;
                              });
                            },
                          ),
                          Marker(
                            markerId: const MarkerId("Origin"),
                            position: LatLng(user["position"]["lat"], user["position"]["long"]),
                            icon: _origin,
                          ),
                          Marker(
                            markerId: const MarkerId("CurrentLocation"),
                            position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                            icon: _currentLoc,
                            onTap: () {
                              setState(() {
                                _gmapController!.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                                      zoom: CAMERAZOOM,
                                      bearing: CAMERABEARING,
                                      tilt: CAMERATILT,
                                    ),
                                  ),
                                );
                                _pinPosition = PIN_VISIBLE_POSITION;
                              });
                            },
                          ),
                        },
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        left: 0,
                        right: 0,
                        bottom: _pinPosition,
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset.zero,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: blue,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: tour['thumnaile'],
                                        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                          child: SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                              strokeWidth: 2,
                                              backgroundColor: red,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${tour["nama"]}", style: theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 5),
                                        Text("Kecamatan ${tour["kecamatan"]}", style: theme.textTheme.bodyText1),
                                      ],
                                    ),
                                  ),
                                  AvatarGlow(
                                    child: IconButton(
                                      onPressed: (() => _gmapController!.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                target: LatLng(tour["position"]["lat"], tour["position"]["long"]),
                                                zoom: CAMERAZOOM,
                                                bearing: CAMERABEARING,
                                                tilt: CAMERATILT,
                                              ),
                                            ),
                                          )),
                                      icon: SvgPicture.asset(marker_tour),
                                    ),
                                    endRadius: 20,
                                    duration: const Duration(seconds: 2),
                                    showTwoGlows: true,
                                    glowColor: red,
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  ClipOval(
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CachedNetworkImage(
                                        imageUrl: "https://ui-avatars.com/api/?name=${user['name']}/?format=svg",
                                        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                          child: SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                              strokeWidth: 2,
                                              backgroundColor: red,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${user["name"]}", style: theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 5),
                                        Text("My Location", style: theme.textTheme.bodyText1),
                                      ],
                                    ),
                                  ),
                                  // SvgPicture.asset(marker, color: pink, height: 30),
                                  AvatarGlow(
                                    child: IconButton(
                                      onPressed: (() => _gmapController!.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                                                zoom: CAMERAZOOM,
                                                bearing: CAMERABEARING,
                                                tilt: CAMERATILT,
                                              ),
                                            ),
                                          )),
                                      icon: SvgPicture.asset(mark_currentloc),
                                    ),
                                    endRadius: 20,
                                    duration: const Duration(seconds: 2),
                                    showTwoGlows: true,
                                    glowColor: blue,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
          }
          return Center(
            child: CircularProgressIndicator(strokeWidth: 2, backgroundColor: red),
          );
        },
      ),
    );
  }
}
// polylines: Set<Polyline>.of(polylines.values),
