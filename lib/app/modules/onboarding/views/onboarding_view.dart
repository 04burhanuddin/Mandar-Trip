import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/shared_value.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 50,
            right: 12,
            child: ElevatedButton(
              onPressed: () => Get.toNamed(Routes.ABOUT),
              child: SvgPicture.asset(info_i, color: white, height: 14),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(1.0),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome to 👋", style: theme.textTheme.headline6),
                        const SizedBox(height: 4),
                        Text("Mandar Trip", style: theme.textTheme.headline3),
                        const SizedBox(height: 8),
                        Text('Find Your Favorite Destination In Polewali Mandar', style: theme.textTheme.subtitle2),
                        const SizedBox(height: 2),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: SvgPicture.asset(traveler),
                ),
                Column(
                  children: <Widget>[
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 55,
                      onPressed: (() => Get.toNamed(Routes.LOGIN)),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Login",
                        style: theme.textTheme.button,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                          top: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                          left: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                          right: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                        ),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 55,
                        onPressed: (() => Get.toNamed(Routes.SIGNUP)),
                        color: blue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Sign Up",
                          style: theme.textTheme.button?.copyWith(color: white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
