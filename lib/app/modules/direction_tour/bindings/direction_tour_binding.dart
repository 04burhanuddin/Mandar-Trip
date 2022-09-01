import 'package:get/get.dart';

import '../controllers/direction_tour_controller.dart';

class DirectionTourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DirectionTourController>(
      () => DirectionTourController(),
    );
  }
}
