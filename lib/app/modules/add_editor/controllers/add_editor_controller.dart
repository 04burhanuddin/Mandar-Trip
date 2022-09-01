import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandar_trip/app/routes/app_pages.dart';

class AddEditorController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController namaC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController kecC = TextEditingController();

  Future addEditor() async {
    if (namaC.text.isNotEmpty && emailC.text.isNotEmpty) {
      try {
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password",
        );
        if (userCredential.user != null) {
          String userID = userCredential.user!.uid;

          firestore.collection("users").doc(userID).set(
            {
              "userID": userID,
              "name": namaC.text,
              "email": emailC.text,
              "kecamatan": kecC.text,
              "role": "editor",
              "createAt": DateTime.now().toIso8601String(),
            },
          );
          await userCredential.user!.sendEmailVerification();
        }
        if (userCredential.user!.emailVerified == false) {
          await FirebaseAuth.instance.signOut();
          Get.offAllNamed(Routes.LOGIN);
          Get.snackbar("Success", "Admin baru berhasil ditambahkan");
        }
        // Get.back();
        print(userCredential); //untuk cek apakah user berhasil dibuat
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Get.snackbar("Error", "Email ini sudah digunakan");
        }
      } catch (e) {
        Get.snackbar("Error", "Tidak dapat mendaftarkan Admin dengan email dan password");
      }
    } else {
      Get.snackbar('Error', 'Nama, Kecamatan dan email tidak boleh kosong');
    }
  }

  @override
  void onClose() {
    super.onClose();
    namaC.dispose();
    emailC.dispose();
    kecC.dispose();
  }
}
