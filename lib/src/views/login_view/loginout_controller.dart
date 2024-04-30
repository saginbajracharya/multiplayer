import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/services/api_services.dart';
import 'package:multiplayer/src/services/firestore_services.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';
import 'package:multiplayer/src/views/home_view/home_view.dart';
import 'package:multiplayer/src/widgets/toast_message_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginoutController extends GetxController{
  final apiendpoint         = ApiServices();
  final email               = TextEditingController();
  final password            = TextEditingController();
  bool showPassword         = true;
  RxBool isProcessingLogin  = false.obs;
  RxBool isProcessingLogout = false.obs;

  login()async{
    if(isProcessingLogin.value) {
      return;
    }
    else{
      String? currentFcmtoken = await read(StorageKeys.fcmTokenKey);
      try{
        isProcessingLogin.value = true;
        update();
        var response = await ApiServices.apiPost(
          'api/login',
          {
            "email": email.text.trim(),
            "password": password.text.trim(),
            "fcm_token": currentFcmtoken
          }
        );
        if(response!=null){
          FirestoreServices.updateUserStatus(true,email.text.trim(),false);
          await write(StorageKeys.usernameKey, response['user']['name']); // Username Save
          await write(StorageKeys.emailKey, response['user']['email']); // Email Save
          await write(StorageKeys.currentApiToken, response['token']); // API TOkEN Save 
          await write(StorageKeys.totalGemKey, response['user']['gem']);
          await write(StorageKeys.totalCoinKey, response['user']['coin']);
          await write(StorageKeys.profilePictureKey, response['user']['profile_picture']); // Profile Picture Save 
          Get.toNamed(HomeView.routeName);
        }
        else{
          showToastMessage('Incorrect Username / Password');
        }
      }
      catch(e){
        log(e.toString());
      }
      finally{
        isProcessingLogin.value = false;
        update();
      }
    }
  }

  logout()async{
    try{
      isProcessingLogout.value = true;
      update();
      var response = await ApiServices.apiPost(
        'api/logout',{}
      );
      if(response!=null){
        //Reset All on Logout
        final HomeController homeCon = Get.find();
        FirestoreServices.updateUserStatus(false,email.text.trim(),false);
        write(StorageKeys.usernameKey, ''); // Username Reset
        write(StorageKeys.emailKey, ''); // Email Reset
        write(StorageKeys.currentApiToken, ''); // Current Api Token Reset
        write(StorageKeys.profilePictureKey,''); // Profile Picture Reset 
        homeCon.username.value="";
        homeCon.isUserLoggedIn.value = false;
        homeCon.checkLoginToken();
        Get.toNamed(HomeView.routeName);
      }
      else{
        showToastMessage('Logout failed');
      }
    }
    catch(e){
      log(e.toString());
    }
    finally{
      isProcessingLogout.value = false;
      update();
    }
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      log('User==>$googleUser');
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      log('GoogleAuth==>$googleAuth');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      if (kDebugMode) {
        print('exception->$e');
      }
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}