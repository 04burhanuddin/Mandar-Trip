import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:mandar_trip/app/modules/detail_tour/controllers/detail_tour_controller.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/shared_value.dart';
import '../controllers/detail_tour_controller.dart';

class DetailTourView extends GetView<DetailTourController> {
  final Map<String, dynamic> tour = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 9, top: 9, bottom: 9),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white.withAlpha(130),
                ),
                child: IconButton(
                  onPressed: (() => Get.back()),
                  icon: SvgPicture.asset(arrowLeft, color: theme.iconTheme.color),
                ),
              ),
            ),
            expandedHeight: Get.height / 5 * 2,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: CachedNetworkImage(
                imageUrl: tour['thumnaile'],
                progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      strokeWidth: 2,
                      backgroundColor: red,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    (tour['nama']),
                    style: theme.textTheme.headline6,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                            imageUrl: tour['thumnaile'],
                            progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  strokeWidth: 2,
                                  backgroundColor: red,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            ("Kecamatan ${tour['kecamatan']}"),
                            style: theme.textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            (tour['kategori']),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    ("Deskripsi Tempat Wisata"),
                    style: theme.textTheme.headline6,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    (tour['deskripsi']),
                    style: const TextStyle(height: 1.6),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          await controller.getLocUser();
          Get.toNamed(Routes.DIRECTION_TOUR, arguments: tour);
        },
        backgroundColor: blue,
        elevation: 0,
        tooltip: "Direction",
        highlightElevation: 50,
        child: SvgPicture.asset(direction, color: white, height: 18),
      ),
    );
  }
}
