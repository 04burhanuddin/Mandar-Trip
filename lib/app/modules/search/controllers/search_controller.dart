import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController search = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var queryAwal = [].obs;
  var tempSearch = [].obs;

  void searchTour(String data) async {
    if (data.isEmpty) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      if (queryAwal.isEmpty && data.length == 1) {
        CollectionReference tours = firestore.collection("tours");
        final result = await tours.where("keyName", isEqualTo: data.substring(0, 1).toUpperCase()).get();
        if (result.docs.isNotEmpty) {
          for (int i = 0; i < result.docs.length; i++) {
            queryAwal.add(result.docs[i].data() as Map<String, dynamic>);
          }
        } else {
          // print("Tidak ada hasil : ");
        }
      }
      if (queryAwal.isNotEmpty) {
        tempSearch.value = [];
        for (var element in queryAwal) {
          if (element["nama"] != null && element["nama"].toString().toLowerCase().contains(data.toLowerCase())) {
            tempSearch.add(element);
          }
        }
      }
    }
    queryAwal.refresh();
    tempSearch.refresh();
  }

  @override
  void onClose() {
    super.onClose();
    search.dispose();
  }
}
