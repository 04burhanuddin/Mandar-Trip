import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../shared/shared_value.dart';
import '../controllers/add_tour_controller.dart';

class AddTourView extends GetView<AddTourController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text('TAMBAH WISATA', style: theme.textTheme.headline6),
        elevation: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(arrowLeft, color: theme.iconTheme.color),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text('Nama Wisata *', style: theme.textTheme.bodyText1),
              const SizedBox(height: 10.0),
              TextFormField(
                cursorColor: grey,
                autocorrect: false,
                style: theme.textTheme.bodyText1,
                controller: controller.nameC,
                decoration: InputDecoration(
                  hintText: 'Input nama wisata',
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
              Text('Kategori *', style: theme.textTheme.bodyText1),
              const SizedBox(height: 10.0),
              TextFormField(
                cursorColor: grey,
                autocorrect: false,
                style: theme.textTheme.bodyText1,
                controller: controller.katC,
                decoration: InputDecoration(
                  hintText: 'Input Kategori',
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
              Text('Kecamatan/Desa *', style: theme.textTheme.bodyText1),
              const SizedBox(height: 10.0),
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
              Text('Deskripsi *', style: theme.textTheme.bodyText1),
              const SizedBox(height: 10.0),
              TextFormField(
                cursorColor: grey,
                autocorrect: false,
                style: theme.textTheme.bodyText1,
                controller: controller.desC,
                decoration: InputDecoration(
                  hintText: 'Input deskripsi',
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Foto *', style: theme.textTheme.bodyText1),
                  TextButton(
                    onPressed: () {
                      controller.pickImage();
                    },
                    child: Text("Pilih Gambar", style: theme.textTheme.bodyText1!.copyWith(color: blue)),
                  ),
                ],
              ),
              Row(
                children: [
                  GetBuilder<AddTourController>(
                    builder: (c) {
                      if (c.image != null) {
                        return SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.file(File(c.image!.path), fit: BoxFit.fill),
                        );
                      } else {
                        return const Text("Tidak Ada Gambar di Pilih");
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Text('* Data lokasi akan secara otomatis diisi. Sesuai posisi sekarang',
                  style: theme.textTheme.subtitle1!.copyWith(fontWeight: FontWeight.normal, color: red)),
              const SizedBox(height: 10),
              MaterialButton(
                minWidth: double.infinity,
                height: 47,
                onPressed: () {
                  controller.addTour(dynamic);
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
      ),
    );
  }
}
