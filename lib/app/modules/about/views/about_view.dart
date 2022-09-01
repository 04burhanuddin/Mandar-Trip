import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../shared/shared_value.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text('ABOUT MANDAR TRIP', style: theme.textTheme.headline6),
        elevation: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(arrowLeft, color: theme.iconTheme.color),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInfo(
                  "Tentang Mandar Trip",
                  "1",
                  "Mandar Trip adalah sistem informasi pariwisata yang ada di kabupaten polewali mandar, aplikasi ini menyediakan informasi objek wisata yang terletak di kabupaten polewali mandar, menyediakan beberapa informasi mengenai detail wisata.",
                  blue,
                  theme,
                ),
                buildInfo(
                  "Informasi Pengguna",
                  "2",
                  "Untuk dapat menggunakan aplikasi Mandar Trip anda perlu mendaftarkan akun terlebih dahuulu untuk bisa menggunakan fitur pada aplikasi data berupa Nama dan Email Serta data lokasi",
                  blue,
                  theme,
                ),
                buildInfo(
                  "Izin Akses Lokasi",
                  "3",
                  "Mandar Trip akan meminta izin akses lokasi Anda, data ini dipergunakan untuk mendapatkan rute wisata ",
                  red,
                  theme,
                ),
                buildInfo(
                  "Izin Akses Penyimpanan",
                  "4",
                  "Mandar Trip akan meminta akses penyimpanan untuk menyimpan theme data aplikasi",
                  yellow,
                  theme,
                ),
                buildInfo(
                  "Contact Us",
                  "5",
                  "Jika mengalami masalah silahkan kontak dev.burhanuddin@gmail.com",
                  green,
                  theme,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfo(String title, String number, String deskripsi, Color color, theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 23,
              width: 23,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Center(child: Text(number, style: theme.textTheme.bodyText1!.copyWith(color: white))),
            ),
            const SizedBox(width: 10),
            Text(title, style: theme.textTheme.headline6),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            Text(deskripsi, style: theme.textTheme.bodyText1, textAlign: TextAlign.justify),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
