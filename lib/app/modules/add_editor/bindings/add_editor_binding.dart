import 'package:get/get.dart';

import '../controllers/add_editor_controller.dart';

class AddEditorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditorController>(
      () => AddEditorController(),
    );
  }
}
