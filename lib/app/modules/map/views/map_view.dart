import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mandar_trip/app/routes/app_pages.dart';

import '../../../shared/shared_value.dart';
import '../controllers/map_controller.dart';

// ignore: must_be_immutable
const double CAMERAZOOM = 16;
const double CAMERATILT = 80;
const double CAMERABEARING = 30;

// ignore: must_be_immutable
class MapView extends GetView<MapController> {
  @override
  final MapController mapController = Get.put(MapController());
  final CustomInfoWindowController _infWindow = CustomInfoWindowController();
  final Set<Marker> markers = {};
  Set<TileOverlay> tileOverlays = const <TileOverlay>{};
  GoogleMapController? _gmapController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.stramDataTour(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            for (var tour in snapshot.data!.docs) {
              // print(tour.id);
              // print("DATA TOURS ; ${tour.data().toString()}");
              markers.add(
                Marker(
                  markerId: MarkerId(tour.id),
                  position: LatLng(
                    (tour.data() as Map<String, dynamic>)["position"]!["lat"],
                    (tour.data() as Map<String, dynamic>)["position"]!["long"],
                  ),
                  onTap: () {
                    _gmapController!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(
                            (tour.data() as Map<String, dynamic>)["position"]?["lat"],
                            (tour.data() as Map<String, dynamic>)["position"]?["long"],
                          ),
                          zoom: CAMERAZOOM,
                          bearing: CAMERABEARING,
                        ),
                      ),
                    );
                    _infWindow.addInfoWindow!(
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.isDarkMode ? Colors.grey.shade900 : Colors.white,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 125,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      imageUrl: "${(tour.data() as Map<String, dynamic>)["thumnaile"]}",
                                      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                          child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                          strokeWidth: 2,
                                          backgroundColor: red,
                                        ),
                                      )),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${(tour.data() as Map<String, dynamic>)["nama"]}",
                                  style: theme.textTheme.subtitle2,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${(tour.data() as Map<String, dynamic>)["deskripsi"]}",
                                  style: theme.textTheme.bodySmall,
                                  maxLines: 2,
                                  // maxLines: 1,
                                ),
                                const SizedBox(height: 8),
                                MaterialButton(
                                  onPressed: (() => Get.toNamed(Routes.DETAIL_TOUR, arguments: tour.data())),
                                  elevation: 0,
                                  minWidth: double.infinity,
                                  color: Colors.grey.shade200,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    "See details",
                                    style: theme.textTheme.bodyText1?.copyWith(
                                      color: Get.isDarkMode ? Colors.black : Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: red,
                            ),
                            child: IconButton(
                              padding: const EdgeInsets.all(2),
                              icon: Icon(
                                Icons.close,
                                color: white,
                                size: 10,
                              ),
                              onPressed: () {
                                _infWindow.hideInfoWindow!();
                              },
                            ),
                          ),
                        ],
                      ),
                      LatLng(
                        (tour.data() as Map<String, dynamic>)["position"]["lat"],
                        (tour.data() as Map<String, dynamic>)["position"]["long"],
                      ),
                    );
                  },
                  icon: controller.markerCostum,
                ),
              );
            }
            return Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  mapToolbarEnabled: false,
                  // liteModeEnabled: false,
                  compassEnabled: false,
                  tileOverlays: tileOverlays,
                  onTap: (position) {
                    _infWindow.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    _infWindow.onCameraMove!();
                  },
                  onMapCreated: (GoogleMapController _controller) async {
                    _gmapController = _controller;
                    _infWindow.googleMapController = _controller;
                    _gmapController!.setMapStyle(controller.mapStyle);
                  },
                  markers: markers,
                  initialCameraPosition: const CameraPosition(target: LatLng(-3.2615965, 119.3315906), zoom: 10, tilt: 80, bearing: 30),
                ),
                CustomInfoWindow(
                  controller: _infWindow,
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width * 0.55,
                  offset: 8,
                ),
              ],
            );
          }
          return Center(
            child: AvatarGlow(
              child: Text("LOADING", style: theme.textTheme.bodyText1),
              endRadius: 80,
              duration: const Duration(seconds: 2),
              glowColor: red,
              showTwoGlows: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        onPressed: () {
          _gmapController!.animateCamera(
              CameraUpdate.newCameraPosition(const CameraPosition(target: LatLng(-3.2615965, 119.3315906), zoom: 10, tilt: 80, bearing: 30)));
        },
        child: SvgPicture.asset(
          focus,
          color: black,
          height: 15,
        ),
      ),
    );
  }
}
