import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/api_calls.dart';
import 'package:multiplayer/src/views/home_view/home_view.dart';

class LoginController extends GetxController{
  final apiendpoint         = ApiCalls();
  final username            = TextEditingController();
  final password            = TextEditingController();
  RxBool isProcessingLogin  = false.obs;

  login()async{
    if(isProcessingLogin.value) {
      return;
    }
    else{
      isProcessingLogin.value = true;
      Future.delayed(const Duration(seconds: 3),(){
        Get.toNamed(HomeView.routeName);
      });
    }
  }
}