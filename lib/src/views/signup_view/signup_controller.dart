import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';
import 'package:multiplayer/src/services/api_services.dart';
import 'package:multiplayer/src/views/login_view/login_view.dart';
import 'package:multiplayer/src/widgets/toast_message_widget.dart';

class SignUpController extends GetxController{
  final name                = TextEditingController();
  final email               = TextEditingController();
  final password            = TextEditingController();
  bool showPassword         = true;
  RxBool isProcessingSignup = false.obs;

  signup()async{
    if(isProcessingSignup.value) {
      return;
    }
    else{
      String? currentFcmtoken = await read(StorageKeys.fcmTokenKey);
      try{
        isProcessingSignup.value = true;
        update();
        var response = await ApiServices.apiPost(
          'api/signup',
          {
            "name" : name.text,
            "email": email.text,
            "password": password.text,
            "fcm_token": currentFcmtoken
          }
        );
        if(response!=null){
          Get.toNamed(LoginView.routeName);
        }
        else{
          showToastMessage('Failed To Register, Please Try Again.');
        }
      }
      catch(e){
        log(e.toString());
      }
      finally{
        isProcessingSignup.value = false;
        update();
      }
    }
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        log('User canceled sign-in');
        return;
      }
      log('User: $googleUser');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      log('GoogleAuth: $googleAuth');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      // Extract user details from Google sign-in
      name.text  = userCredential.user?.displayName??'';
      email.text = userCredential.user?.email??'';
      password.text = userCredential.user?.uid??'';
      // Use the extracted user details to sign up the user
      await signup();
    } catch (e) {
      log('Exception: $e');
    }
  }
}