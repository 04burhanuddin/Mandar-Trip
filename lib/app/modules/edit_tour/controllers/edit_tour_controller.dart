import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditTourController extends GetxController {
  TextEditingController namaC = TextEditingController();
  TextEditingController katC = TextEditingController();
  TextEditingController kecC = TextEditingController();
  TextEditingController desC = TextEditingController();
  TextEditingController latC = TextEditingController();
  TextEditingController longC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  XFile? image;

  Future<DocumentSnapshot<Object?>> getDataTour(String docID) async {
    DocumentReference refTours = firestore.collection("tours").doc(docID);
    return refTours.get();
  }

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

  void editTour(String nama, String kat, String kec, String des, String lat, String long, String docID) async {
    if (namaC.text.isNotEmpty && katC.text.isNotEmpty && kecC.text.isNotEmpty && desC.text.isNotEmpty) {
      try {
        var _latitude = double.parse(latC.text.toString());
        var _longitude = double.parse(longC.text.toString());
        Map<String, dynamic> data = {
          "nama": namaC.text.toString(),
          "kategori": katC.text.toString(),
          "kecamatan": kecC.text.toString(),
          "deskripsi": desC.text.toString(),
          "position": {
            "lat": _latitude,
            "long": _longitude,
          },
          "createAt": DateTime.now().toIso8601String(),
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;
          await storage.ref('/tours/$docID/thumnaile.$ext').putFile(file);
          String urlImage = await storage.ref('/tours/$docID/thumnaile.$ext').getDownloadURL();
          data.addAll({
            "thumnaile": urlImage.toString(),
          });
        }
        await firestore.collection('tours').doc(docID).update(data);
        Get.defaultDialog(
          title: "Success",
          middleText: "Berhasil mengubah data tour",
          onConfirm: () {
            namaC.clear();
            katC.clear();
            kecC.clear();
            desC.clear();
            Get.back();
            Get.back();
          },
          textConfirm: "OKE",
        );
      } catch (e) {
        Get.snackbar("Error", "Tidak dapat mengubah data tour!");
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    namaC.dispose();
    katC.dispose();
    kecC.dispose();
    desC.dispose();
  }
}
