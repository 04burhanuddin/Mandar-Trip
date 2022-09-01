// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandar_trip/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  var hidden = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passwordC.text,
        );
        // print(userCredential);
        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passwordC.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.DASHBOARD);
            }
          } else {
            if (userCredential.user!.emailVerified == false) {
              isLoading.value = false;
              Get.defaultDialog(
                title: 'Not Verification!',
                middleText:
                    "Akun anda belum diverifikasi silakan cek email untuk verifikasi, jika anda tidak menerima email silahkan klik resend email",
                actions: [
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cencel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //karna kemungkinen akan error maka tray and catch
                      try {
                        await userCredential.user!.sendEmailVerification();
                        Get.back();
                        Get.snackbar('Success', 'Email verifikasi berhasil dikirim, silahkan cek email');
                      } catch (e) {
                        Get.snackbar('Error', 'Tidak dapat mengirim email verifikasi');
                      }
                    },
                    child: const Text('Resend Email'),
                  ),
                ],
              );
            } else {
              Get.snackbar("Error", "Terjadi kesalahan login");
            }
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar('Error', 'Akun anda tidak ditemukan');
        } else if (e.code == 'wrong-password') {
          Get.snackbar('Error', 'Password tidak sesuai');
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Error', 'Anda tidak dapat login');
      }
    } else {
      Get.snackbar('Error', 'Email dan Password harus diisi, tidak boleh kosong');
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailC.dispose();
    passwordC.dispose();
  }
}
