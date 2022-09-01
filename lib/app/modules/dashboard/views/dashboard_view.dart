import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandar_trip/app/modules/map/views/map_view.dart';
import 'package:mandar_trip/app/shared/shared_value.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:mandar_trip/app/modules/search/views/search_view.dart';
import 'package:mandar_trip/app/modules/profile/views/profile_view.dart';
import 'package:mandar_trip/app/modules/dashboard/controllers/dashboard_controller.dart';

// ignore: must_be_immutable
class DashboardView extends GetView<DashboardController> {
  DashboardController changeNavigation = Get.put(DashboardController());
  final view = [
    MapView(),
    SearchView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: changeNavigation.selectedIndex.value,
          children: view,
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SalomonBottomBar(
            currentIndex: changeNavigation.selectedIndex.value,
            onTap: (index) {
              changeNavigation.ChangeIndex(index);
            },
            margin: const EdgeInsets.only(right: 40, left: 40, top: 7, bottom: 7),
            items: [
              SalomonBottomBarItem(
                icon: SvgPicture.asset(home, height: 20),
                title: const Text("Home"),
                selectedColor: blue,
                activeIcon: SvgPicture.asset(home, color: blue, height: 15),
              ),
              SalomonBottomBarItem(
                icon: SvgPicture.asset(search_, height: 20),
                title: const Text("Search"),
                selectedColor: green,
                activeIcon: SvgPicture.asset(search_, color: green, height: 15),
              ),
              SalomonBottomBarItem(
                icon: SvgPicture.asset(account, height: 20),
                title: const Text("Profile"),
                selectedColor: red,
                activeIcon: SvgPicture.asset(account, color: red, height: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
