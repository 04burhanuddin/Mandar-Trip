import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../shared/shared_value.dart';
import '../controllers/add_editor_controller.dart';

class AddEditorView extends GetView<AddEditorController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD ADMIN', style: theme.textTheme.headline6),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text('Nama Lengkap *', style: theme.textTheme.bodyText1),
            const SizedBox(height: 10),
            TextFormField(
              cursorColor: grey,
              autocorrect: false,
              style: theme.textTheme.bodyText1,
              controller: controller.namaC,
              decoration: InputDecoration(
                hintText: 'Input full name',
                hintStyle: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Kecamatan *', style: theme.textTheme.bodyText1),
            const SizedBox(height: 10),
            TextFormField(
              cursorColor: grey,
              autocorrect: false,
              style: theme.textTheme.bodyText1,
              controller: controller.kecC,
              decoration: InputDecoration(
                hintText: 'Input kecamatan',
                hintStyle: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Email *', style: theme.textTheme.bodyText1),
            const SizedBox(height: 10),
            TextFormField(
              cursorColor: grey,
              autocorrect: false,
              style: theme.textTheme.bodyText1,
              controller: controller.emailC,
              decoration: InputDecoration(
                hintText: 'Input email',
                hintStyle: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                ),
              ),
            ),
            const SizedBox(height: 30),
            MaterialButton(
              minWidth: double.infinity,
              height: 47,
              onPressed: () {
                controller.addEditor();
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
