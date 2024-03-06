import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multiplayer/src/views/home_view/home_view.dart';
import 'package:multiplayer/src/views/level_view/level_1.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_detail_view/lobby_detail_view.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_view.dart';
import 'package:multiplayer/src/views/login_view/login_view.dart';
import 'package:multiplayer/src/views/settings/settings_view.dart';
import 'package:multiplayer/src/views/signup_view/signup_view.dart';
import 'package:multiplayer/src/views/splash_view/splash_view.dart';
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
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return SafeArea(
          child: GetMaterialApp(
            home: child,
            popGesture: true,
            navigatorKey: navigatorKey,
            useInheritedMediaQuery: false,
            debugShowCheckedModeBanner: false,
            title: AppLocalizations.of(context)!.appTitle,
            onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
            transitionDuration: const Duration(milliseconds: 500),
            defaultTransition: Transition.rightToLeft,
            themeMode: settingsController.themeMode,
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
            theme: ThemeData(
              useMaterial3:true,
              applyElevationOverlayColor: false,
              appBarTheme: const AppBarTheme(
                scrolledUnderElevation: 0.0
              )
            ),
            darkTheme: ThemeData.dark(
              useMaterial3:true,
            ),
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      return SettingsView(controller: settingsController);
                    case HomeView.routeName:
                      return const HomeView();
                    case LobbyView.routeName:
                      return const LobbyView();
                    case LobbyDetailView.routeName:
                      return const LobbyDetailView();
                    case LoginView.routeName:
                      return const LoginView();
                    case SignUpView.routeName:
                      return const SignUpView();
                    case Level1.routeName:
                      return const Level1();
                    case SplashView.routeName:
                    default:
                      return const SplashView();
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
