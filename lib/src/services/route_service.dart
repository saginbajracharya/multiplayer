import 'package:get/get.dart';
import 'package:multiplayer/src/views/forgot_password_view/forgot_password.dart';
import 'package:multiplayer/src/views/forgot_password_view/reset_password.dart';
import 'package:multiplayer/src/views/game_view/level_01.dart';
import 'package:multiplayer/src/views/home_view/home_view.dart';
import 'package:multiplayer/src/views/level_view/level.dart';
import 'package:multiplayer/src/views/store_view/store_view.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_view.dart';
import 'package:multiplayer/src/views/login_view/login_view.dart';
import 'package:multiplayer/src/views/settings/settings_view.dart';
import 'package:multiplayer/src/views/signup_view/signup_view.dart';
import 'package:multiplayer/src/views/splash_view/splash_view.dart';
import 'package:multiplayer/src/views/settings/settings_controller.dart';
import 'package:multiplayer/src/views/settings/profile_edit_view/profile_edit_view.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_detail_view/lobby_detail_view.dart';

class RouteManager {
  static List<GetPage> getPages(SettingsController settingsController) {
    return [
      GetPage(name: SettingsView.routeName, page: () => SettingsView(controller: settingsController)),
      GetPage(name: HomeView.routeName, page: () => const HomeView()),
      GetPage(name: LobbyView.routeName, page: () => const LobbyView()),
      GetPage(name: LobbyDetailView.routeName, page: () => const LobbyDetailView()),
      GetPage(name: LoginView.routeName, page: () => const LoginView()),
      GetPage(name: SignUpView.routeName, page: () => const SignUpView()),
      GetPage(name: Level.routeName, page: () => const Level()),
      GetPage(name: StoreView.routeName, page: () => const StoreView()),
      GetPage(name: SplashView.routeName, page: () => const SplashView()),
      GetPage(name: ProfileEditView.routeName, page: () => const ProfileEditView()),
      GetPage(name: ForgotPasswordView.routeName, page: () => const ForgotPasswordView()),
      GetPage(name: ResetPasswordView.routeName, page: () => const ResetPasswordView()),
      GetPage(name: Level01.routeName, page: () => const Level01()),
    ];
  }
}