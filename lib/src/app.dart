import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/services/audio_services.dart';
import 'package:multiplayer/src/services/notification_services.dart';
import 'package:multiplayer/src/services/route_service.dart';
import 'package:multiplayer/src/views/settings/settings_controller.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;
  @override
  Widget build(BuildContext context) {
    final AudioNavigatorObserver audioNavigatorObserver = AudioNavigatorObserver();
    // Handle notifications when the app is in the foreground
    getPushedNotification(context);
    return GetMaterialApp(
      popGesture: true,
      navigatorKey: navigatorKey,
      navigatorObservers: [
        audioNavigatorObserver, // Use audioNavigatorObserver here
      ],
      useInheritedMediaQuery: false,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
      transitionDuration: const Duration(milliseconds: 300),
      defaultTransition: Transition.fadeIn,
      themeMode: settingsController.themeMode,
      locale: settingsController.currentLocale,
      theme: lightTheme,
      darkTheme: darkTheme,
      opaqueRoute: true,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ne', ''), // Nepali, no country code
      ],
      fallbackLocale: const Locale('en', ''),
      getPages: RouteManager.getPages(settingsController),
    );
  }
}
