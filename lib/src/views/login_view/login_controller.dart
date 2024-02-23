import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/api_calls.dart';
import 'package:multiplayer/src/views/home_view/home_view.dart';
import 'package:multiplayer/src/widgets/toast_message_widget.dart';

class LoginController extends GetxController{
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
}