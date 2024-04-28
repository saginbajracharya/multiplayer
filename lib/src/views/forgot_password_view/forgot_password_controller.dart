import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/services/api_services.dart';
import 'package:multiplayer/src/views/forgot_password_view/reset_password.dart';
import 'package:multiplayer/src/views/login_view/login_view.dart';

class ForgotPasswordController extends GetxController{
  final apiendpoint               = ApiServices();
  final email                     = TextEditingController();
  final token                     = TextEditingController();
  final password                  = TextEditingController();
  RxBool isProcessingReqToken     = false.obs;
  RxBool isProcessingResetPass    = false.obs;
  bool showPassword               = true;

  requestRestPassToken()async{
    if(isProcessingReqToken.value) {
      return;
    }
    else{
      try{
        isProcessingReqToken.value = true;
        update();
        var response = await ApiServices.apiPost(
          'api/forgotPassword',
          {
            "email": email.text.trim(),
          }
        );
        if(response!=null){
          Get.toNamed(ResetPasswordView.routeName);
        }
      }
      catch(e){
        log(e.toString());
      }
      finally{
        isProcessingReqToken.value = false;
        update();
      }
    }
  }

  resetPassword()async{
    if(isProcessingReqToken.value) {
      return;
    }
    else{
      try{
        isProcessingResetPass.value = true;
        update();
        var response = await ApiServices.apiPost(
          'api/resetPassword',
          {
            "email": email.text.trim(),
            "token": token.text.trim(),
            "password":password.text.trim()
          }
        );
        if(response!=null){
          Get.toNamed(LoginView.routeName);
        }
      }
      catch(e){
        log(e.toString());
      }
      finally{
        isProcessingResetPass.value = false;
        update();
      }
    }
  }
}