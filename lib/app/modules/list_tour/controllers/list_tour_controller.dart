import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ListTourController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  Stream<QuerySnapshot<Object?>> stramDataTour() {
    CollectionReference tour = firestore.collection('tours');
    return tour.orderBy("createAt", descending: true).snapshots();
  }

  void deleteTour(String id) async {
    final delStorage = storage.ref('tours/$id/thumnaile.jpg');
    DocumentReference tour = firestore.collection('tours').doc(id);
    try {
      Get.defaultDialog(
        title: "Delete Tour",
        middleText: "Apakah kamu yakin menghapus wisata ini?",
        onConfirm: () async {
          await tour.delete();
          Get.back();
          Get.snackbar("Success", "Berhasil menghapus wisata");
        },
        textConfirm: "YES",
        textCancel: "NO",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Tidak dapat menghapus wisata",
      );
    } finally {
      await delStorage.delete();
    }
  }
}
