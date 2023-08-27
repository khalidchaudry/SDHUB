import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdhub/utils/constants.dart';
import 'package:sdhub/utils/firebase.dart';

class CreateNotesController extends GetxController {
  bool checkTitle = false;
  bool checkDesc = false;
  bool loading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  updateTitleValue() {
    checkTitle = !checkTitle;
    update();
  }

  updateDescValue() {
    checkDesc = !checkDesc;
    update();
  }

  loader() async {
    loading = true;
    await Future.delayed(
      const Duration(seconds: 3),
    );
    loading = false;
    update();
  }

  // create note
  createNotes({required BuildContext context}) async {
    try {
      await firestore.collection('myNotes').add({
        'title': titleController.text,
        'desc': descController.text,
        'uNumber': auth.currentUser!.phoneNumber,
        'uEmail': auth.currentUser!.email,
        'createDate': DateFormat().format(DateTime.now()),
      });
      showAlert(title: 'Successfully!', message: 'Uploaded');
      titleController.clear();
      descController.clear();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      log(e.toString());
    }
    update();
  }
}
