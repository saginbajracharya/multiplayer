import 'package:get_storage/get_storage.dart';

final box = GetStorage();

class StorageKeys {
  static const String username     = 'username';
  static const String email        = 'email';
  static const String isLoggedIn   = 'isLoggedIn';
  static const String apiToken     = 'apiToken';
}

read(String storageName){
  dynamic result = box.read(storageName)??"";
  return result;
}

write(String storageName,dynamic value){
  box.write(storageName,value??"");
}

remove(String storageName){
  box.remove(storageName);
}