import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var pass = true.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void signUp() async {
    if (nameC.text.isNotEmpty && emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        if (userCredential.user != null) {
          String userID = userCredential.user!.uid;

          firestore.collection("users").doc(userID).set(
            {
              "userID": userID,
              "name": nameC.text,
              "email": emailC.text,
              "role": "visitor",
              "createAt": DateTime.now().toIso8601String(),
            },
          );
          await userCredential.user!.sendEmailVerification();
          FirebaseAuth.instance.signOut();
        }
        Get.defaultDialog(
          title: "Success",
          middleText: "Behasil mendaftar, silahkan cek email untuk verikasi",
          onConfirm: () {
            nameC.clear();
            emailC.clear();
            passC.clear();
            Get.back();
            Get.back();
          },
          textConfirm: "OKE",
        );
        // print(userCredential); untuk cek apakah user berhasil dibuat
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Erorr", "Password terlalu pendek minimal 6 karakter");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Error", "email telah digunakan");
        }
      } catch (e) {
        Get.snackbar("Error", "Tidak dapat mendaftar");
      }
    } else {
      Get.snackbar('Error', 'Nama, Email dan Password tidak boleh kosong');
    }
  }

  @override
  void onClose() {
    super.onClose();
    nameC.dispose();
    emailC.dispose();
    passC.dispose();
  }
}
