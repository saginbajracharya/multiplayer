import 'dart:developer';

import 'package:get/get.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';

class HomeController extends GetxController{
  RxBool isUserLoggedIn = false.obs;
  RxString username = "".obs;
  RxString userProfilePic = "".obs;

  getUserName()async{
    username.value = await read(StorageKeys.usernameKey);
    update();
  }

  getProfilePic()async{
    userProfilePic.value = await read(StorageKeys.profilePictureKey);
    update();
  }

  // Checks if user is already logged in
  // Checks for token received after login
  checkLoginToken()async{
    String loginToken = await read(StorageKeys.currentApiToken.toString());
    log(loginToken);
    if(loginToken!= ''){
      isUserLoggedIn.value = true;
    }
    else{
      isUserLoggedIn.value = false;
    }
  }
}