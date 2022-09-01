import 'package:get/get.dart';

import '../controllers/detail_tour_controller.dart';

class DetailTourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTourController>(
      () => DetailTourController(),
    );
  }
}
