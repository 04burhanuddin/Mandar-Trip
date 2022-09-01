import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/shared_value.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
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
          onPressed: (() {
            controller.nameC.clear();
            controller.emailC.clear();
            controller.passC.clear();
            Get.toNamed(Routes.ONBOARDING);
          }),
          icon: SvgPicture.asset(arrowLeft, color: theme.iconTheme.color),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Sign Up', style: theme.textTheme.headline4),
              const SizedBox(height: 50),
              TextFormField(
                autocorrect: false,
                cursorColor: grey,
                controller: controller.nameC,
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter your name',
                  hintStyle: theme.textTheme.bodyText1,
                  label: Text('Full Name *', style: theme.textTheme.bodyText1),
                  suffixIcon: IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(account, height: 17, color: grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              Obx(
                () => TextFormField(
                  style: theme.textTheme.bodyText1,
                  autocorrect: false,
                  cursorColor: grey,
                  controller: controller.passC,
                  obscureText: controller.pass.value,
                  obscuringCharacter: '•',
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your password',
                    hintStyle: theme.textTheme.bodyText1,
                    label: Text('Password *', style: theme.textTheme.bodyText1),
                    suffixIcon: IconButton(
                      onPressed: () => controller.pass.toggle(),
                      icon: controller.pass.isTrue
                          ? Icon(Icons.remove_red_eye, color: grey, size: 22)
                          : Icon(Icons.remove_red_eye_outlined, color: grey, size: 22),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    controller.signUp();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Sign Up',
                      style: theme.textTheme.button?.copyWith(color: white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Have an account?', style: theme.textTheme.bodyText1),
                  TextButton(
                    onPressed: (() => Get.toNamed(Routes.LOGIN)),
                    child: Text(
                      'Click here to Login',
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
