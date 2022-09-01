import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/shared_value.dart';
import '../controllers/list_user_controller.dart';

class ListUserView extends GetView<ListUserController> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('LIST ADMIN', style: theme.textTheme.headline6),
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
                  Get.toNamed(Routes.ADD_EDITOR);
                },
                child: Text("ADD ADMIN", style: theme.textTheme.headline6!.copyWith(color: blue))),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.stramDataUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var listAllUser = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: listAllUser.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://ui-avatars.com/api/?name=${(listAllUser[index].data() as Map<String, dynamic>)["name"]}/?format=svg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text("${(listAllUser[index].data() as Map<String, dynamic>)["name"]}"),
                    subtitle: Text("Kecamatan ${(listAllUser[index].data() as Map<String, dynamic>)["kecamatan"]}"),
                    trailing: SvgPicture.asset(arrowSwap, color: theme.iconTheme.color),
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
