import 'dart:developer';
import 'package:get/get.dart';

class DebugService extends GetxController {
  showLog(String message) {
    log(message);
  }
}