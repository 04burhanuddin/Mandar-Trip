import 'package:get/get.dart';

import '../controllers/list_tour_controller.dart';

class ListTourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListTourController>(
      () => ListTourController(),
    );
  }
}
