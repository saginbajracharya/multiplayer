import 'package:get/get.dart';

class LobbyFormController extends GetxController{
  RxBool isProcessingAllUsers  = false.obs;
  RxBool isUpdatingReady = false.obs; 
  List userList = [].obs;
}