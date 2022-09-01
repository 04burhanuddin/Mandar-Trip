import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  var curPass = true.obs;
  var newPass = true.obs;
  var confPass = true.obs;
  TextEditingController currPassC = TextEditingController();
  TextEditingController newPassC = TextEditingController();
  TextEditingController confPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> changePassword() async {
    if (currPassC.text.isNotEmpty && newPassC.text.isNotEmpty && confPassC.text.isNotEmpty) {
      if (newPassC.text == confPassC.text) {
        isLoading.value = true;
        try {
          String email = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(email: email, password: currPassC.text);
          await auth.currentUser!.updatePassword(newPassC.text);
          Get.back();
          Get.snackbar("Success", "Password baru berhasil Diupdate");
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar("Error", "Password lama yang dimasukkan salah, tidak dapaat mengganti password");
          } else {
            Get.snackbar("Error", e.code.toLowerCase());
          }
          Get.snackbar("Error", "Password not changed");
        } catch (e) {
          isLoading.value = false;
          Get.snackbar("Error", "Password not changed");
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar("Error", "New Password dan Konfirmasi password tidak sesuai");
      }
    } else {
      Get.snackbar("Error", "Password lama, Password baru dan Konformasi password tidak boleh kosong");
    }
  }

  @override
  void onClose() {
    super.onClose();
    currPassC.dispose();
    newPassC.dispose();
    confPassC.dispose();
  }
}
