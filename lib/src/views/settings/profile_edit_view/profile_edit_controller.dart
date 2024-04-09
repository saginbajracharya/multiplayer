import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditController extends GetxController{
  final name                = TextEditingController();
  final email               = TextEditingController();
  RxBool isProcessingSave   = false.obs;
  XFile? selectedProfileImage;

  Future<void> pickProfileImages() async {
    selectedProfileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}