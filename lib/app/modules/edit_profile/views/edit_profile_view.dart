import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../shared/shared_value.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // print(user);
    // print(user); // {'name': 'example', 'email': 'example'}
    controller.nameC.text = user['name'];
    controller.emailC.text = user['email'];
    return Scaffold(
      appBar: AppBar(
        title: Text('EDIT PROFILE', style: theme.textTheme.headline6),
        elevation: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(arrowLeft, color: theme.iconTheme.color),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 3),
            Text('Email', style: theme.textTheme.bodyText1),
            const SizedBox(height: 10),
            TextFormField(
              readOnly: true,
              autocorrect: false,
              style: theme.textTheme.bodyText1,
              controller: controller.emailC,
              decoration: InputDecoration(
                hintText: 'Input email',
                hintStyle: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Nama *', style: theme.textTheme.bodyText1),
            const SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              cursorColor: grey,
              style: theme.textTheme.bodyText1,
              controller: controller.nameC,
              decoration: InputDecoration(
                hintText: 'Input name',
                hintStyle: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(5),
                )),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
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
                    await controller.editProfile(user["userID"]);
                  }
                },
                color: blue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: grey, style: BorderStyle.solid),
                ),
                child: Text(
                  controller.isLoading.isFalse ? 'SIMPAN' : 'Loading...',
                  style: theme.textTheme.button?.copyWith(color: white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
