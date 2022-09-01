import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.snackbar("Success", "Email reset password berhasil dikirim, Silahkan cek email anda");
      } catch (e) {
        Get.snackbar("Error", "Tidak dapat mengirim email reset password");
      } finally {
        isLoading.value = true;
      }
    } else {
      Get.snackbar("Error", "Email tidak boleh kosong");
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailC.dispose();
  }
}
