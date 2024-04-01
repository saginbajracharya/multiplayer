import 'package:get_storage/get_storage.dart';

final box = GetStorage();

class StorageKeys {
  static const String usernameKey        = 'username';
  static const String emailKey           = 'email';
  static const String isLoggedInKey      = 'isLoggedIn';
  static const String apiTokenKey        = 'apiToken';
  static const String audioOnKey         = 'audioOn';
  static const String currentLanguageKey = 'currentLanguage';
  static const String currentThemeKey    = 'currentTheme';
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