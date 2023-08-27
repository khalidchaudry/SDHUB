import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdhub/view/home_screen/home_screen.dart';
import '../utils/utils.dart';

class CreateController extends GetxController {
  String verficationId = '';
  String countryCode = '+92';
  String countryName = 'Pakistan';
  bool checkAuth = false;

  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  updateAuthValue() {
    checkAuth = !checkAuth;
    update();
  }

  updateCountryInfo({
    required String code,
    required String name,
  }) {
    countryCode = code;
    countryName = name;
    update();
  }

  verifyPhoneNumber(
      {required String phoneController, required String countryCode}) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: countryCode + phoneController,
          verificationCompleted: (phoneAuthCredential) {
            auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            showAlert(title: 'Attention!', message: 'Verification Failed');
            log(error.toString());
            log(countryCode + phoneController);
          },
          codeSent: (verificationId, forceResendingToken) {
            verficationId = verificationId;
            forceResendingToken;
          },
          codeAutoRetrievalTimeout: (verificationId) {
            verficationId = verificationId;
          });
      update();
    } catch (e) {
      return showAlert(title: 'Attention!', message: e.toString());
    }
  }

  signInWithPhoneNumber({required String otpController}) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verficationId, smsCode: otpController);
      await auth.signInWithCredential(credential);
      if (auth.currentUser != null) {
        await firestore.collection('users').doc(auth.currentUser!.uid).set({
          'phoneNumber': auth.currentUser!.phoneNumber,
        });
      }
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      log(e.toString());
    }
  }

  // sign in with google

  googleSigninMethod() async {
    var gUser = await GoogleSignIn().signIn();
    var gAuth = await gUser!.authentication;
    var credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        if (auth.currentUser != null) {
          await firestore.collection('users').doc(auth.currentUser!.uid).set({
            'name': auth.currentUser!.displayName,
            'email': auth.currentUser!.email,
            'picture': auth.currentUser!.photoURL,
          });
        }
        Get.offAll(() => const HomeScreen());
      },
    );

    return await auth.signInWithCredential(credential);
  }
}
