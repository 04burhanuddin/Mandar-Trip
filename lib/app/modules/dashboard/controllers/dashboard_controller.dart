import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  // ignore: non_constant_identifier_names
  void ChangeIndex(int index) {
    // print(index);
    selectedIndex.value = index;
  }
}
