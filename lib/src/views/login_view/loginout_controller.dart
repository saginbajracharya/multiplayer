import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/services/api_services.dart';
import 'package:multiplayer/src/services/firestore_services.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';
import 'package:multiplayer/src/views/home_view/home_view.dart';
import 'package:multiplayer/src/widgets/toast_message_widget.dart';

class LoginoutController extends GetxController{
  final apiendpoint         = ApiServices();
  final email               = TextEditingController();
  final password            = TextEditingController();
  bool showPassword         = true;
  RxBool isProcessingLogin  = false.obs;

  login()async{
    if(isProcessingLogin.value) {
      return;
    }
    else{
      try{
        isProcessingLogin.value = true;
        update();
        var response = await ApiServices.apiPost(
          'api/login',
          {
            "email": email.text.trim(),
            "password": password.text.trim(),
          }
        );
        if(response!=null){
          FirestoreServices.updateUserStatus(true,email.text.trim(),false);
          await write(StorageKeys.usernameKey, response['user']['email']);
          await write(StorageKeys.emailKey, response['user']['email']);
          await write(StorageKeys.apiTokenKey, response['token']);
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
    final HomeController homeCon = Get.find();
    FirestoreServices.updateUserStatus(false,email.text.trim(),false);
    write(StorageKeys.usernameKey, '');
    write(StorageKeys.emailKey, '');
    write(StorageKeys.apiTokenKey, '');
    homeCon.username.value="";
    homeCon.checkLoginToken();
    Get.toNamed(HomeView.routeName);
  }
}