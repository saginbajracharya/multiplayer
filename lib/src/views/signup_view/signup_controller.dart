import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/services/api_services.dart';
import 'package:multiplayer/src/views/login_view/login_view.dart';
import 'package:multiplayer/src/widgets/toast_message_widget.dart';

class SignUpController extends GetxController{
  final signupformKey       = GlobalKey<FormState>();
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
      try{
        isProcessingSignup.value = true;
        update();
        var response = await ApiServices.apiPostLeftToManage(
          'api/users',
          {
            "name" : name.text,
            "email": email.text,
            "password": password.text,
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
}