import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sdhub/view/auth_screen/auth_screen.dart';
import '../utils/utils.dart';

class HomeController extends GetxController {
  List<dynamic> emailList = [];
  getEmails() async {
    QuerySnapshot querySnapshot = await firestore.collection('myNotes').get();
    emailList = querySnapshot.docs.map((doc) => doc.get('uEmail')).toList();
    update();
    log('Email......${emailList.toString()}');
  }

// logout
  logout() async {
    try {
      Get.defaultDialog(
          middleText: 'Sure!, you want to logout?',
          onCancel: () {},
          onConfirm: () async {
            await auth.signOut();
            Get.offAll(() => const AuthScreen());
          });
    } catch (e) {
      log(e.toString());
    }
    update();
  }

// delete note
  deleteNote({required String id}) async {
    try {
      await firestore.collection('myNotes').doc(id).delete();
      Get.back();
      showAlert(title: 'Successfully!', message: 'Deleted');
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getEmails();
  }
}
