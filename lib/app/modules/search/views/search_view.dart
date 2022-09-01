import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:mandar_trip/app/routes/app_pages.dart';
import 'package:mandar_trip/app/shared/shared_value.dart';

import '../controllers/search_controller.dart';

// ignore: must_be_immutable
class SearchView extends GetView<SearchController> {
  SearchController search = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: SizedBox(
            height: 45,
            child: TextField(
              cursorColor: grey,
              style: theme.textTheme.bodyText1,
              controller: controller.search,
              onChanged: (value) => controller.searchTour(value),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                fillColor: theme.inputDecorationTheme.fillColor,
                prefixIcon: IconButton(
                  onPressed: null,
                  icon: SvgPicture.asset(search_, height: 20, color: grey),
                ),
                prefixIconColor: green,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(width: 10.0, color: white, style: BorderStyle.solid),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: theme.inputDecorationTheme.border!.borderSide.color),
                ),
                hintStyle: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
                hintText: "Search Tour",
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.tempSearch.isEmpty
            ? Center(
                child: AvatarGlow(
                  child: Text("TIDAK ADA DATA", style: theme.textTheme.bodyText1),
                  endRadius: 100,
                  duration: const Duration(seconds: 2),
                  glowColor: green,
                  showTwoGlows: true,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: controller.tempSearch.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CachedNetworkImage(
                          imageUrl: controller.tempSearch[index]['thumnaile'],
                          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                              child: ClipOval(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                strokeWidth: 2,
                                backgroundColor: red,
                              ),
                            ),
                          )),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Text("${controller.tempSearch[index]["nama"]}", style: theme.textTheme.headline6),
                  subtitle: Text("${controller.tempSearch[index]["kategori"]}", style: theme.textTheme.bodyText1),
                  trailing: GestureDetector(
                    onTap: () => Get.toNamed(
                      Routes.DETAIL_TOUR,
                      arguments: controller.tempSearch[index],
                    ),
                    child: Chip(
                      label: Text("Detail", style: theme.textTheme.bodyText1!.copyWith(color: black)),
                      backgroundColor: green.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
