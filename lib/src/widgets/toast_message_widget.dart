import 'package:fluttertoast/fluttertoast.dart';

showToastMessage(message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
  );
}