import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:mandar_trip/app/routes/app_pages.dart';

import '../../../shared/shared_value.dart';
import '../controllers/list_tour_controller.dart';

class ListTourView extends GetView<ListTourController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('LIST TOUR', style: theme.textTheme.headline6),
        elevation: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(arrowLeft, color: theme.iconTheme.color),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.ADD_TOUR);
                },
                child: Text("ADD TOUR", style: theme.textTheme.headline6!.copyWith(color: blue))),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.stramDataTour(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var listAllTour = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.only(right: 16, top: 5, left: 1),
              child: ListView.builder(
                itemCount: listAllTour.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      extentRatio: 0.50,
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            (Get.toNamed(Routes.EDIT_TOUR, arguments: listAllTour[index].id));
                          },
                          backgroundColor: green,
                          foregroundColor: white,
                          icon: Icons.edit,
                        ),
                        SlidableAction(
                          onPressed: (BuildContext context) async {
                             controller.deleteTour(listAllTour[index].id);
                          },
                          backgroundColor: red,
                          foregroundColor: white,
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CachedNetworkImage(
                              imageUrl: (listAllTour[index].data() as Map<String, dynamic>)["thumnaile"],
                              progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                  child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  strokeWidth: 2,
                                  backgroundColor: red,
                                ),
                              )),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      title: Text("${(listAllTour[index].data() as Map<String, dynamic>)["nama"]}"),
                      subtitle: Text("Kecamatan ${(listAllTour[index].data() as Map<String, dynamic>)["kecamatan"]}"),
                      trailing: SvgPicture.asset(arrowSwap, color: theme.iconTheme.color),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
