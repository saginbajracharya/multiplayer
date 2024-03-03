import 'dart:developer';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';
import 'package:multiplayer/src/views/home_view/home_view.dart';

class SplashController extends GetxController{
  
  checkAndNavigate()async{
    String apiToken = await read(StorageKeys.apiToken.toString());
    log(apiToken);
    Get.toNamed(HomeView.routeName);
    // if(apiToken!= ''){
    //   Get.toNamed(HomeView.routeName);
    // }
    // else{
    //   Get.toNamed(LoginView.routeName);
    // }
  }

}