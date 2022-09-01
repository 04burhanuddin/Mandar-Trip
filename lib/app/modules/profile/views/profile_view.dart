import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:mandar_trip/app/routes/app_pages.dart';

import '../../../controllers/theme_controller.dart';
import '../../../shared/shared_value.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  final ProfileController controller = Get.put(ProfileController());
  final ThemesController _themesController = Get.find();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("PROFIL", style: theme.textTheme.headline5),
        actions: [
          TextButton(
            onPressed: () {
              controller.deleteAccount();
            },
            child: SvgPicture.asset(
              trash,
              color: red,
            ),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: AvatarGlow(
                  child: Text("LOADING", style: theme.textTheme.bodyText1),
                  endRadius: 80,
                  duration: const Duration(seconds: 2),
                  glowColor: red,
                  showTwoGlows: true,
                ),
              );
            } else if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;
              return user.isEmpty
                  ? Center(
                      child: AvatarGlow(
                        child: Text("PLEASE WAIT", style: theme.textTheme.bodyText1),
                        endRadius: 80,
                        duration: const Duration(seconds: 2),
                        glowColor: red,
                        showTwoGlows: true,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Center(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AvatarGlow(
                                        endRadius: 60,
                                        duration: const Duration(seconds: 2),
                                        showTwoGlows: true,
                                        glowColor: black,
                                        child: ClipOval(
                                          child: SizedBox(
                                            height: 90,
                                            width: 90,
                                            child: Image.network(
                                              "https://ui-avatars.com/api/?name=${user['name']}/?format=svg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text("${user["name"]}", style: theme.textTheme.subtitle1),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${user["email"]}",
                                    style: theme.textTheme.bodyText1,
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 33,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border(
                                            bottom: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                                            top: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                                            left: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                                            right: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () => Get.toNamed(Routes.EDIT_PROFILE, arguments: user),
                                          child: Text('Edit Profile', style: theme.textTheme.bodyText1),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        height: 33,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          border: Border(
                                            bottom: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                                            top: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                                            left: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                                            right: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: (() => Get.toNamed(Routes.CHANGE_PASSWORD)),
                                          child: Text('Ubah Password', style: theme.textTheme.bodyText1),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              children: <Widget>[Text('Informasi Lainnya', style: theme.textTheme.headline6)],
                            ),
                            const SizedBox(height: 20),
                            if (user["role"] == "administrator")
                              _listTileOtherInformation('Kelola Admin', addAdmin, 'Administrator', blue, theme, onTab: () {
                                Get.toNamed(Routes.LIST_USER);
                              }),
                            if (user["role"] == "administrator" || user["role"] == "editor")
                              _listTileOtherInformation('Kelola Wisata', addTour, 'Admin', green, theme, onTab: () {
                                Get.toNamed(Routes.LIST_TOUR);
                              }),
                            GetBuilder<ThemesController>(
                              builder: (_) {
                                return _listTileOtherInformation('Pilih Tema', dark, _.theme, pink, theme,
                                    onTab: () => _bottomSheetAppearnce(theme, _.theme));
                              },
                            ),
                            _listTileOtherInformation('Tentang Mandar Trip', info, '', purple, theme, onTab: () {
                              Get.toNamed(Routes.ABOUT);
                            }),
                            _listTileOtherInformation('Versi Aplikasi', mobile, 'V.1.0', yellow, theme, onTab: () {}),
                            _listTileOtherInformation('Logout', logout, '', red, theme, onTab: () {
                              controller.logout();
                            }),
                          ],
                        ),
                      ),
                    );
            } else {
              return Center(
                child: AvatarGlow(
                  child: Text("LOADING", style: theme.textTheme.bodyText1),
                  endRadius: 80,
                  duration: const Duration(seconds: 2),
                  glowColor: blue,
                  showTwoGlows: true,
                ),
              );
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }

  Widget _listTileOtherInformation(String title, String icon, String trailing, Color color, theme, {onTab}) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Container(
        width: 40,
        height: Get.height / 3,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withAlpha(30),
        ),
        child: Center(
          child: SvgPicture.asset(icon, color: color, height: 20),
        ),
      ),
      title: Text(title, style: theme.textTheme.bodyText1),
      trailing: SizedBox(
        width: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(trailing, style: theme.textTheme.bodyText2), SvgPicture.asset(arrowRight, height: 13, width: 13)],
        ),
      ),
      onTap: onTab,
    );
  }

  _bottomSheetAppearnce(ThemeData theme, String current) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        height: Get.height / 4.40,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: SvgPicture.asset(light, color: blue),
              title: Text("Terang", style: theme.textTheme.bodyText1),
              onTap: () {
                _themesController.setTheme('Terang');
                Get.back();
              },
              trailing: Icon(
                Icons.check,
                size: 20,
                color: current == 'Terang' ? Colors.blue : Colors.transparent,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: SvgPicture.asset(dark, color: orange),
              title: Text("Gelap", style: theme.textTheme.bodyText1),
              onTap: () {
                _themesController.setTheme('Gelap');
                Get.back();
              },
              trailing: Icon(
                Icons.check,
                size: 20,
                color: current == 'Gelap' ? Colors.orange : Colors.transparent,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: SvgPicture.asset(system, color: grey),
              title: Text("Sistem", style: theme.textTheme.bodyText1),
              onTap: () {
                _themesController.setTheme('Sistem');
                Get.back();
              },
              trailing: Icon(
                Icons.check,
                size: 20,
                color: current == 'Sistem' ? Colors.blueGrey : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
