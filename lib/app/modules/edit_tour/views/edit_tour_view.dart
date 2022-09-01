import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../shared/shared_value.dart';
import '../controllers/edit_tour_controller.dart';

class EditTourView extends GetView<EditTourController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text('EDIT WISATA', style: theme.textTheme.headline6),
        elevation: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(arrowLeft, color: theme.iconTheme.color),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getDataTour(Get.arguments),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              controller.namaC.text = data["nama"];
              controller.katC.text = data['kategori'];
              controller.kecC.text = data['kecamatan'];
              controller.desC.text = data['deskripsi'];
              controller.latC.text = data['position']["lat"].toString();
              controller.longC.text = data['position']["long"].toString();
              return Padding(
                padding: const EdgeInsets.all(20),
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
                      controller: controller.namaC,
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
                    const SizedBox(height: 20),
                    Text('Edit Posisi', style: theme.textTheme.bodyText1),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Latitude *"),
                              const SizedBox(height: 5),
                              TextFormField(
                                cursorColor: grey,
                                autocorrect: false,
                                style: theme.textTheme.bodyText1,
                                controller: controller.latC,
                                decoration: InputDecoration(
                                  hintText: 'Input latitude',
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
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Longitude *"),
                              const SizedBox(height: 5),
                              TextFormField(
                                cursorColor: grey,
                                autocorrect: false,
                                style: theme.textTheme.bodyText1,
                                controller: controller.longC,
                                decoration: InputDecoration(
                                  hintText: 'Input longitude',
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
                            ],
                          ),
                        ),
                      ],
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
                        GetBuilder<EditTourController>(
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
                    const SizedBox(height: 30.0),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 47,
                      onPressed: () => controller.editTour(
                        controller.namaC.text,
                        controller.katC.text,
                        controller.kecC.text,
                        controller.desC.text,
                        controller.latC.text,
                        controller.longC.text,
                        Get.arguments,
                      ),
                      color: blue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: grey, style: BorderStyle.solid),
                      ),
                      child: Text("UPDATE TOUR", style: theme.textTheme.button?.copyWith(color: white)),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
        ),
      ),
    );
  }
}
