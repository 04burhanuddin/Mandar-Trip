import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mandar_trip/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String userID = auth.currentUser!.uid;
    yield* firestore.collection('users').doc(userID).snapshots();
  }

  // jika delete akun data pada firestore tidak akan terhapus gunakan extension untuk
  // membantu dalam membersihkan data user yang tidak digunakan
  void deleteAccount() async {
    try {
      Get.defaultDialog(
        title: "Delete Account",
        middleText: "Apakah kamu yakin ingin menghapus akun?",
        onConfirm: () async {
          await auth.currentUser!.delete();
          Get.offAllNamed(Routes.LOGIN);
        },
        textConfirm: "YES",
        textCancel: "NO",
      );
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat menghapus akun!");
    }
  }

  void logout() async {
    try {
      Get.defaultDialog(
        title: "Logout",
        middleText: "Apakah kamu yakin ingin keluar?",
        onConfirm: () async {
          await FirebaseAuth.instance.signOut();
          Get.offAllNamed(Routes.LOGIN);
        },
        textConfirm: "YES",
        textCancel: "NO",
      );
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat logout!");
    }
  }
}
