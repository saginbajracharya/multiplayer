import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';
import 'package:multiplayer/src/services/api_services.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';
import 'package:multiplayer/src/widgets/toast_message_widget.dart';

class ProfileEditController extends GetxController{
  final name                = TextEditingController();
  final email               = TextEditingController();
  RxBool isProcessingSave   = false.obs;
  Rx<XFile?> selectedProfileImage = Rx<XFile?>(null);

  getCurrentUser()async{
    name.text=await read(StorageKeys.usernameKey);
    email.text=await read(StorageKeys.emailKey);
  }

  Future<void> pickProfileImages() async {
    XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedProfileImage.value = pickedImage;
    }
  }

  editProfile()async{
    if(isProcessingSave.value) {
      return;
    }
    else{
      try{
        isProcessingSave.value = true;
        update();
        var response = await ApiServices.apiPost(
          'api/updateProfile',
          {
            "name": name.text.trim(),
            "email": email.text.trim(),
            "_method":"PUT"
          },
          imagePath: selectedProfileImage.value?.path,
          imageFieldName: 'profile_picture'
        );
        if(response!=null){
          final HomeController homeCon = Get.put(HomeController());
          await write(StorageKeys.usernameKey, response['user']['name']); // Username Save
          await write(StorageKeys.emailKey, response['user']['email']); // Email Save
          await write(StorageKeys.profilePictureKey, response['user']['profile_picture']); // Profile Picture Save 
          homeCon.getUserName();
          homeCon.getProfilePic();
          showToastMessage('Succesfully Saved');
        }
        else{
          showToastMessage('Edit Profile Failed');
        }
      }
      catch(e){
        log(e.toString());
      }
      finally{
        isProcessingSave.value = false;
        update();
      }
    }
  }

}