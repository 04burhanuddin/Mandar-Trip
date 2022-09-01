import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddTourController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController nameC = TextEditingController();
  TextEditingController katC = TextEditingController();
  TextEditingController kecC = TextEditingController();
  TextEditingController desC = TextEditingController();

  final ImagePicker picker = ImagePicker();
  XFile? image;
  final storage = FirebaseStorage.instance;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image!.name);
      print(image!.name.split(".").last);
      print(image!.path);
    } else {
      print(image);
    }
    update();
  }

  void addTour(Position) async {
    Map<String, dynamic> dataResponse = await determinePosition();
    if (nameC.text.isNotEmpty && katC.text.isNotEmpty && kecC.text.isNotEmpty && desC.text.isNotEmpty) {
      try {
        DocumentReference tourID = firestore.collection("tours").doc();
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.path.split(".").last;
          String idStorage = tourID.id;
          await storage.ref('/tours/$idStorage/thumnaile.$ext').putFile(file);
          String urlImage = await storage.ref('/tours/$idStorage/thumnaile.$ext').getDownloadURL();
          var _latitude = double.parse(dataResponse["position"].latitude.toString());
          var _longitude = double.parse(dataResponse["position"].longitude.toString());
          await tourID.set(
            {
              "tourID": idStorage.toString(),
              "nama": nameC.text.toString(),
              "keyName": nameC.text.substring(0, 1).toUpperCase(),
              "kategori": katC.text.toString(),
              "kecamatan": kecC.text.toString(),
              "deskripsi": desC.text.toString(),
              "createAt": DateTime.now().toIso8601String(),
              "position": {
                "lat": _latitude,
                "long": _longitude,
              },
              "thumnaile": urlImage.toString(),
            },
          );
          Get.back();
          Get.snackbar("Success", "Wisata baru berhasil ditambahkan");
        } else {}
      } catch (e) {
        Get.snackbar("Error", "Tidak dapat menamahakan Wisata!");
      }
    } else {
      Get.snackbar('Error', 'Semau TextFiled haris diisi, tidak boleh kosong');
    }
  }

  @override
  void onClose() {
    super.onClose();
    nameC.dispose();
    katC.dispose();
    kecC.dispose();
    desC.dispose();
  }

  // void getLoc() async {
  //   Map<String, dynamic> dataResponse = await determinePosition();
  //   if (dataResponse["error"] != true) {
  //     Position position = dataResponse["position"];
  //     Get.snackbar("${dataResponse["message"]}", "${position.latitude}, ${position.longitude}");
  //   } else {
  //     Get.snackbar("Error", dataResponse["message"]);
  //   }
  // }

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
