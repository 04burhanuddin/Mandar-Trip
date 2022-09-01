import 'package:get/get.dart';

import '../controllers/add_tour_controller.dart';

class AddTourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTourController>(
      () => AddTourController(),
    );
  }
}
