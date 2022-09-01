import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/shared_value.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New Password', style: theme.textTheme.headline5),
            const SizedBox(height: 5),
            const Text('Gunakan password yang kuat, Password baru ini yang akan digunakan pada saat login ulang!'),
            const SizedBox(height: 60),
            Obx(() => TextFormField(
                  cursorColor: grey,
                  autocorrect: false,
                  style: theme.textTheme.bodyText1,
                  controller: controller.newPass,
                  obscureText: controller.showPass.value,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your new password',
                    hintStyle: theme.textTheme.bodyText1,
                    suffixIcon: IconButton(
                      onPressed: () => controller.showPass.toggle(),
                      icon: controller.showPass.isTrue
                          ? Icon(Icons.remove_red_eye, color: grey, size: 22)
                          : Icon(Icons.remove_red_eye_outlined, color: grey, size: 22),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                    ),
                  ),
                )),
            const SizedBox(height: 25),
            MaterialButton(
              minWidth: double.infinity,
              height: 54,
              onPressed: () {
                controller.newPassword();
              },
              color: blue,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: grey, style: BorderStyle.solid),
              ),
              child: Text("SIMPAN", style: theme.textTheme.button?.copyWith(color: white)),
            ),
          ],
        ),
      ),
    );
  }
}
