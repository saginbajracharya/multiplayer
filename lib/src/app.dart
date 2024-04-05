import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multiplayer/src/common/styles.dart';
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
    // Handle notifications when the app is in the foreground
    getPushedNotification(context);
    return GetMaterialApp(
      popGesture: true,
      navigatorKey: navigatorKey,
      useInheritedMediaQuery: false,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
      transitionDuration: const Duration(milliseconds: 200),
      defaultTransition: Transition.zoom,
      themeMode: settingsController.themeMode,
      locale: settingsController.currentLocale,
      theme: lightTheme,
      darkTheme: darkTheme,
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
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => RouteManager(
            settings: settings, 
            controller: settingsController,
          ),
        );
      },
    );
  }
}
