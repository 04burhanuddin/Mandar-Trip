import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/shared_value.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: IconButton(
          // onPressed: (() => Get.toNamed(Routes.ONBOARDING)),
          onPressed: () {
            Get.toNamed(Routes.ONBOARDING);
            controller.passwordC.clear();
            controller.emailC.clear();
          },
          icon: SvgPicture.asset(arrowLeft, color: theme.iconTheme.color),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Login', style: theme.textTheme.headline4),
              const SizedBox(height: 50),
              TextFormField(
                autocorrect: false,
                cursorColor: grey,
                style: theme.textTheme.bodyText1,
                controller: controller.emailC,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter your email',
                  hintStyle: theme.textTheme.bodyText1,
                  label: Text('Email *', style: theme.textTheme.bodyText1),
                  suffixIcon: IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(email, height: 17, color: grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => TextFormField(
                    autocorrect: false,
                    cursorColor: grey,
                    style: theme.textTheme.bodyText1,
                    controller: controller.passwordC,
                    obscureText: controller.hidden.value,
                    obscuringCharacter: '•',
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      hintText: 'Enter your password',
                      hintStyle: theme.textTheme.bodyText1,
                      label: Text('Password *', style: theme.textTheme.bodyText1),
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidden.toggle(),
                        icon: controller.hidden.isTrue
                            ? Icon(Icons.remove_red_eye, color: grey, size: 22)
                            : Icon(Icons.remove_red_eye_outlined, color: grey, size: 22),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                      ),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.FORGET_PASSWORD),
                    child: Text(
                      'Lupa Password ?',
                      style:
                          theme.textTheme.bodyText1?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.maxFinite,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.login();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        controller.isLoading.isFalse ? 'Login' : 'Loading...',
                        style: theme.textTheme.bodyText1?.copyWith(color: white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?', style: theme.textTheme.bodyText1),
                  TextButton(
                    onPressed: (() => Get.toNamed(Routes.SIGNUP)),
                    child: Text(
                      'Click here to Sign Up',
                      style: theme.textTheme.bodyText1?.copyWith(color: blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
