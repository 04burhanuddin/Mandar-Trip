import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class DetailTourController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> getLocUser() async {
    Map<String, dynamic> dataResponse = await determinePosition();
    if (dataResponse["error"] != true) {
      Position position = dataResponse["position"];
      updatePosisi(position);
    } else {
      Get.snackbar("Error", dataResponse["message"]);
    }
  }

  Future<void> updatePosisi(Position position) async {
    String uid = auth.currentUser!.uid;
    await firestore.collection("users").doc(uid).update(
      {
        "position": {
          "lat": position.latitude,
          "long": position.longitude,
        },
      },
    );
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {
        'message': "Tidak dapat mengambl GPS, dari device ini",
        'error': true,
      };
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {
          'message': "Izin penggunaan GPS ditolak",
          'error': true,
        };
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return {
        'message': "Settingan akses GPS tidak diizinkan, silahkan ubah pada pengaturan",
        'error': true,
      };
    }
    Position position = await Geolocator.getCurrentPosition();
    return {
      'position': position,
      'message': "Berhasil mendapatkan lokasi wisata",
      'error': false,
    };
  }
}
