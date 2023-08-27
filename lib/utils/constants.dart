import 'package:flutter/material.dart';
import 'package:get/get.dart';

var size = Get.size;
var bgColor = const Color(0xFF053149);

showAlert({required String title, required message}) {
  Get.snackbar(
    title,
    message,
    shouldIconPulse: true,
    dismissDirection: DismissDirection.startToEnd,
    backgroundColor: Colors.green,
    icon: const Icon(
      Icons.warning_amber_outlined,
      color: Colors.white,
      size: 30,
    ),
    colorText: Colors.white,
    backgroundGradient: const LinearGradient(colors: [
      Colors.blueAccent,
      Colors.blue,
      Colors.indigo,
      Colors.indigoAccent
    ]),
  );
}
