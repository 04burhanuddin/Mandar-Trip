import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class NewPasswordController extends GetxController {
  var showPass = true.obs;
  TextEditingController newPass = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void newPassword() async {
    if (newPass.text.isNotEmpty) {
      if (newPass.text != "password") {
        // tray untuk mengecek kondisi passwaor strong apa tidak valid or not
        try {
          // sebelum logout email di save dulu untuk keperluan login otomatis
          String email = auth.currentUser!.email!;
          await auth.currentUser!.updatePassword(newPass.text);
          await auth.signOut();
          // masuk lagi
          await auth.signInWithEmailAndPassword(
            email: email,
            password: newPass.text,
          );
          Get.offAllNamed(Routes.DASHBOARD);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            Get.snackbar('Error', 'Password terlalu pendek minimal 6 karakter');
          }
        } catch (e) {
          Get.snackbar('Error', 'Tidak dapat mengganti password baru');
        }
      } else {
        Get.snackbar('Error', 'New Password harus diganti');
      }
    } else {
      Get.snackbar('Error', 'New password tidak boleh kosong!');
    }
  }

  @override
  void onClose() {
    super.onClose();
    newPass.dispose();
  }
}
