import 'package:get/get.dart';
import 'package:multiplayer/src/common/api_calls.dart';
import 'package:multiplayer/src/common/firestore_service.dart';
import 'package:multiplayer/src/models/user_model.dart';

class HomeController extends GetxController{
  RxBool isProcessingAllUsers  = false.obs;
  RxBool isUpdatingReady = false.obs; 
  List userList = [].obs;

  getAllUsers()async{
    if(isProcessingAllUsers.value) {
      return;
    }
    else{
      try{
        isProcessingAllUsers.value = true;
        var response = await ApiCalls.apiGet('/api/users','');
        if(response != null){
          userList = response.map((userData) => UserModel.fromJson(userData)).toList();
          return true;
        }
      }
      finally{
        isProcessingAllUsers.value = false;
        update();
      }
    }
  }

  updateUserReadyStatus(email,bool ready){
    if(isUpdatingReady.value) {
      return;
    }
    else{
      try{
        isUpdatingReady.value = true;
        FirestoreServices.updateUserStatus(true,email,ready);
      }
      finally{
        isUpdatingReady.value = false;
        update();
      }
    }
  }
}