import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/utils.dart';

class UpdateNotesController extends GetxController {
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
  updateNotes({required BuildContext context, required String id}) async {
    try {
      await firestore.collection('myNotes').doc(id).update({
        'title': titleController.text,
        'desc': descController.text,
        'createDate': DateFormat().format(DateTime.now()),
      });
      showAlert(title: 'Successfully!', message: 'Updated');
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
