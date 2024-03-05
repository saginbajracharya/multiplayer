import 'dart:developer';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';
import 'package:multiplayer/src/views/home_view/home_view.dart';
// ignore: depend_on_referenced_packages
// import 'package:http/http.dart' as http;
// import 'package:connectivity_plus/connectivity_plus.dart';

class SplashController extends GetxController{
  RxBool online = true.obs;
  
  checkAndNavigate()async{
    String apiToken = await read(StorageKeys.apiTokenKey.toString());
    log(apiToken);
    Get.toNamed(HomeView.routeName);
  }

  // //checkInitialConnectivity
  // checkInitialConnectivity() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
  //     try {
  //       var response = await http.get(Uri.parse("https://www.google.com"));
  //       if (response.statusCode == 200) {
  //         online.value = true;
  //       } else {
  //         online.value = false;
  //       }
  //     } catch(e) {
  //       online.value = false;
  //     }
  //   } else {
  //     online.value = false;
  //   }
  //   checkForConnectivityChange();
  //   return online.value;
  // }

  // //check if connectivity changed
  // checkForConnectivityChange() {
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
  //     if (result == ConnectivityResult.mobile ||
  //         result == ConnectivityResult.wifi ||
  //         result == ConnectivityResult.ethernet) {
  //       try {
  //         var response = await http.get(Uri.parse("https://www.google.com"));
  //         if (response.statusCode == 200) {
  //           online.value = true;
  //         } else {
  //           online.value = false;
  //         }
  //       } catch (e) {
  //         online.value = false;
  //       }
  //     } else {
  //       online.value = false;
  //     }
  //   });
  // }

}