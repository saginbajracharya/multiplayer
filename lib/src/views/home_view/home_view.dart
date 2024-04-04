import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/audio_manager.dart';
import 'package:multiplayer/src/common/constant.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';
import 'package:multiplayer/src/views/level_view/level_1.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_view.dart';
import 'package:multiplayer/src/views/login_view/login_view.dart';
import 'package:multiplayer/src/views/login_view/loginout_controller.dart';
import 'package:multiplayer/src/views/settings/settings_view.dart';
import 'package:multiplayer/src/views/signup_view/signup_view.dart';
import 'package:multiplayer/src/views/store_view/store_view.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiplayer/src/widgets/animated_bg.dart';
import 'package:multiplayer/src/widgets/logo_widget.dart';
import 'package:upgrader/upgrader.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/home_view';

  @override
  State<HomeView> createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> with TickerProviderStateMixin{
  final HomeController homeCon = Get.put(HomeController());
  final LoginoutController loginoutCon = Get.put(LoginoutController());
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    homeCon.getUserName();
    // Start the animation
    homeCon.checkLoginToken();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: UpgradeAlert(
        upgrader: Upgrader(
          countryCode            : 'en',
          debugDisplayAlways     : false,
          debugDisplayOnce       : false,
          debugLogging           : false,
          durationUntilAlertAgain: Duration.zero,
          minAppVersion          : '0.0.0'
        ),
        child: BackgroundScaffold( 
          child: UpgradeAlert(
            upgrader: Upgrader(
              debugDisplayAlways     : false,
              durationUntilAlertAgain: Duration.zero,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(width: double.infinity),
                const SizedBox(width: double.infinity),
                // Title
                const LogoWidget(seconds: 1),
                const SizedBox(width: double.infinity),
                // Profile
                Column(
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: gold,
                        child: CircleAvatar(
                          radius: 46.0,
                          backgroundColor: grey,
                          backgroundImage: NetworkImage(profilePlaceHolder),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:10),
                      child: Obx(()=>
                        Text(
                          homeCon.username.value!=""?homeCon.username.value:AppLocalizations.of(context)!.player1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: white
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: double.infinity),
                // Play/Login Buttons
                Obx(()=> 
                  homeCon.isUserLoggedIn.value
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //MULTIPLAYER Play Button
                      AButtonWidget(
                        btnText: AppLocalizations.of(context)!.multiplayerMode, 
                        onPressed:() async{
                          Get.toNamed(LobbyView.routeName);
                        },
                      ),
                      //SOLO Play Button
                      AButtonWidget(
                        btnText: AppLocalizations.of(context)!.soloMode, 
                        onPressed:() async{
                          Get.toNamed(Level1.routeName);
                        },
                      ),
                      //Shop Button
                      AButtonWidget(
                        btnText: AppLocalizations.of(context)!.store, 
                        onPressed:() async{
                          Get.toNamed(StoreView.routeName);
                        },
                      ),
                      // LOGOUT
                      AButtonWidget(
                        btnText: AppLocalizations.of(context)!.logout, 
                        onPressed:() async{
                          loginoutCon.logout();
                        },
                      ),
                    ],
                  )
                  : Column(
                    children: [
                      // Login
                      AButtonWidget(
                        btnText: AppLocalizations.of(context)!.login, 
                        onPressed:() async{
                          Get.toNamed(LoginView.routeName);
                        },
                      ),
                      // Signup / Register
                      AButtonWidget(
                        btnText: AppLocalizations.of(context)!.signup, 
                        onPressed:() async{
                          Get.toNamed(SignUpView.routeName);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: double.infinity),
                //Audio On/Off Icon_Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Audio On/Off
                    Obx(()=>
                      IconButton(
                        onPressed: (){
                          if(AudioManager().isPlaying.value){
                            AudioManager().pause();
                          }
                          else{
                            AudioManager().play('assets/audio/theme_song.mp3');
                          }
                        },
                        icon: Icon(
                          AudioManager().isPlaying.value
                          ?Icons.music_note_outlined
                          :Icons.music_off,
                          color: white
                        ),
                      ),
                    ),
                    // Settings View
                    IconButton(
                      onPressed: (){
                        Get.toNamed(SettingsView.routeName);
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: white
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}