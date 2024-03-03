import 'dart:developer';

import 'package:get/get.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';

class HomeController extends GetxController{
  RxBool isUserLoggedIn = false.obs;

  // Checks if user is already logged in
  // Checks for token received after login
  checkLoginToken()async{
    String loginToken = await read(StorageKeys.apiToken.toString());
    log(loginToken);
    if(loginToken!= ''){
      isUserLoggedIn.value = true;
    }
    else{
      isUserLoggedIn.value = false;
    }
  }
}