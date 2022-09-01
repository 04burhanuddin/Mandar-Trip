import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ListUserController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Object?>> stramDataUser() {
    CollectionReference user = firestore.collection('users');
    return user.where("role", isEqualTo: "editor").snapshots();
    // return user.snapshots();
  }

  void deleteUser(String id) {
    DocumentReference user = firestore.collection('users').doc(id);
    try {
      Get.defaultDialog(
        title: "Delete Admin",
        middleText: "Apakah kamu yakin menghapus Admin ini?",
        onConfirm: () async {
          await user.delete();
          Get.back();
          Get.snackbar("Success", "Berhasil menghapus Admin");
        },
        textConfirm: "YES",
        textCancel: "NO",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Error",
        middleText: "Tidak dapat menghapus Admin!",
      );
    }
  }
}
