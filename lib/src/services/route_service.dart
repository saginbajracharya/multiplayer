import 'package:flutter/material.dart';
import 'package:multiplayer/src/views/home_view/home_view.dart';
import 'package:multiplayer/src/views/level_view/level_1.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_detail_view/lobby_detail_view.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_view.dart';
import 'package:multiplayer/src/views/login_view/login_view.dart';
import 'package:multiplayer/src/views/settings/settings_controller.dart';
import 'package:multiplayer/src/views/settings/settings_view.dart';
import 'package:multiplayer/src/views/signup_view/signup_view.dart';
import 'package:multiplayer/src/views/splash_view/splash_view.dart';
import 'package:multiplayer/src/views/store_view/store_view.dart';

class RouteManager extends StatelessWidget {
  const RouteManager({
    Key? key, 
    required this.settings, 
    required this.controller,
  }) : super(key: key);

  final RouteSettings settings;
  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    switch (settings.name) {
      case SettingsView.routeName:
        return SettingsView(controller: controller);
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
      case StoreView.routeName:
        return const StoreView();
      case SplashView.routeName:
      default:
        return const SplashView();
    }
  }
}