import 'package:get/get.dart';

import '../controllers/edit_tour_controller.dart';

class EditTourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditTourController>(
      () => EditTourController(),
    );
  }
}
