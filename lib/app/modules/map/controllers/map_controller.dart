import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Object?>> stramDataTour() async* {
    CollectionReference tour = firestore.collection('tours');
    yield* tour.snapshots();
  }

  BitmapDescriptor markerCostum = BitmapDescriptor.defaultMarker;
  void _costumMarker() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/icons/marker_tour.png").then((_marker) {
      markerCostum = _marker;
    });
  }

  late String mapStyle;
  @override
  void onInit() {
    super.onInit();
    _costumMarker();
    rootBundle.loadString('assets/map/mapstyle.txt').then((string) {
      mapStyle = string;
    });
  }
}
