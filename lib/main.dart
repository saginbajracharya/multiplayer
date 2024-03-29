import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multiplayer/src/common/audio_manager.dart';
import 'package:multiplayer/src/services/firestore_services.dart';
import 'package:multiplayer/src/services/notification_services.dart';
import 'src/app.dart';
import 'src/views/settings/settings_controller.dart';
import 'src/views/settings/settings_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initilize Firebase
  await GetStorage.init();
  //Sign In to Firebase Anonymously
  FirestoreServices.logInAnonymously();
  // Notification Permission and Setups
  await requestPerm();
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  // Put game into full screen mode on mobile devices.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // Lock the game to portrait mode on mobile devices.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Initialize Audio
  AudioManager().init();
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
