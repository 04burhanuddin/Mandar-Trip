import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  RxBool isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  Future<void> editProfile(String uid) async {
    if (nameC.text.isNotEmpty && emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await firestore.collection('users').doc(uid).update(
          {
            'name': nameC.text.toString(),
            'email': emailC.text.toString(),
          },
        );
        Get.back();
        Get.snackbar("Success", "Berhasil mengubah profil");
      } catch (e) {
        Get.snackbar("Error", "Tidak dapat mengubah Profile");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
