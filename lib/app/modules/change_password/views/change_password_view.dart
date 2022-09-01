import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../shared/shared_value.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('CHANGE PASSWORD', style: theme.textTheme.headline6),
        elevation: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(arrowLeft, color: theme.iconTheme.color),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text('Password lama *', style: theme.textTheme.bodyText1),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: grey,
                autocorrect: false,
                obscureText: controller.curPass.value,
                obscuringCharacter: '•',
                style: theme.textTheme.bodyText1,
                controller: controller.currPassC,
                decoration: InputDecoration(
                  hintText: 'Current password',
                  hintStyle: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => controller.curPass.toggle(),
                    icon: controller.curPass.isTrue
                        ? Icon(Icons.remove_red_eye, color: grey, size: 22)
                        : Icon(Icons.remove_red_eye_outlined, color: grey, size: 22),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Password baru *', style: theme.textTheme.bodyText1),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: grey,
                autocorrect: false,
                obscureText: controller.newPass.value,
                obscuringCharacter: '•',
                style: theme.textTheme.bodyText1,
                controller: controller.newPassC,
                decoration: InputDecoration(
                  hintText: 'New password',
                  hintStyle: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => controller.newPass.toggle(),
                    icon: controller.newPass.isTrue
                        ? Icon(Icons.remove_red_eye, color: grey, size: 22)
                        : Icon(Icons.remove_red_eye_outlined, color: grey, size: 22),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Konfirmasi password baru *', style: theme.textTheme.bodyText1),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: grey,
                autocorrect: false,
                obscureText: controller.confPass.value,
                obscuringCharacter: '•',
                style: theme.textTheme.bodyText1,
                controller: controller.confPassC,
                decoration: InputDecoration(
                  hintText: 'Confirm new password',
                  hintStyle: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => controller.confPass.toggle(),
                    icon: controller.confPass.isTrue
                        ? Icon(Icons.remove_red_eye, color: grey, size: 22)
                        : Icon(Icons.remove_red_eye_outlined, color: grey, size: 22),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Obx(
                () => MaterialButton(
                  minWidth: double.infinity,
                  height: 47,
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.changePassword();
                    }
                  },
                  color: blue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: grey, style: BorderStyle.solid),
                  ),
                  child: Text(
                    controller.isLoading.isFalse ? 'UPDATE PASSWORD' : 'Loading...',
                    style: theme.textTheme.button?.copyWith(color: white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
