import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/api_calls.dart';
import 'package:multiplayer/src/common/firestore_service.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';
import 'package:multiplayer/src/views/home_view/home_view.dart';
import 'package:multiplayer/src/views/login_view/login_view.dart';
import 'package:multiplayer/src/widgets/toast_message_widget.dart';

class LoginoutController extends GetxController{
  final apiendpoint         = ApiCalls();
  final formKey             = GlobalKey<FormState>();
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
        var response = await ApiCalls.apiPost(
          '/api/login',
          {
            "email": email.text.trim(),
            "password": password.text.trim(),
          }
        );
        if(response!=null){
          FirestoreServices.updateUserStatus(true,email.text.trim());
          await write(StorageKeys.email, response['user']['email']);
          await write(StorageKeys.apiToken, response['token']);
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
    FirestoreServices.updateUserStatus(false,email.text.trim());
    write(StorageKeys.email, '');
    write(StorageKeys.apiToken, '');
    Get.toNamed(LoginView.routeName);
  }
}