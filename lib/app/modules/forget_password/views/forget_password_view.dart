import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../shared/shared_value.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Forget Password?', style: theme.textTheme.headline5),
            const SizedBox(height: 10),
            Text(
              'Pastikan email yang anda masukkan sama dengan email yang digunakan pada melakukan Mendaftar dan email masih aktif, untuk mendapatkan email Reset Password!',
              textAlign: TextAlign.justify,
              style: theme.textTheme.bodyText2,
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: SvgPicture.asset(arrowLeft, color: Get.isDarkMode ? Colors.white : Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              cursorColor: grey,
              autocorrect: false,
              style: theme.textTheme.bodyText1,
              controller: controller.emailC,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter your email *',
                hintStyle: theme.textTheme.bodyText1,
                // label: Text('Input email', style: theme.textTheme.bodyText1),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: SvgPicture.asset(email, height: 17, color: grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.maxFinite,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.sendEmail();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      controller.isLoading.isFalse ? 'Send Email' : 'Email Sudah Dikirim',
                      style: theme.textTheme.bodyText1?.copyWith(color: white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
