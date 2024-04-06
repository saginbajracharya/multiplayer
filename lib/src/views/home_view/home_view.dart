import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/services/audio_services.dart';
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
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Title
                const Positioned(
                  top: kToolbarHeight+50,
                  child: LogoWidget(seconds: 1)
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: kToolbarHeight+150),
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
                            padding: const EdgeInsets.symmetric(vertical:20),
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
                      const SizedBox(height: 20),
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
                                Get.toNamed(
                                  LobbyView.routeName,
                                );
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
                            GetBuilder(
                              init: LoginoutController(),
                              builder: (_) {
                                return AButtonWidget(
                                  btnText: AppLocalizations.of(context)!.logout, 
                                  onPressed:() async{
                                    if(loginoutCon.isProcessingLogout.value==false){
                                      loginoutCon.logout();
                                    }
                                  },
                                  child: loginoutCon.isProcessingLogout.value 
                                  ?const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator()
                                  )
                                  :Text(AppLocalizations.of(context)!.logout,style: const TextStyle(color: white)),
                                );
                              }
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
                    ],
                  ),
                ),
                //Audio On/Off Icon_Button && settings
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Audio On/Off
                      Obx(()=>
                        IconButton(
                          onPressed: (){
                            if(AudioServices().isPlaying.value){
                              AudioServices().pause();
                            }
                            else{
                              AudioServices().play(AudioFiles.themeSong);
                            }
                          },
                          icon: Icon(
                            AudioServices().isPlaying.value
                            ?Icons.music_note_outlined
                            :Icons.music_off,
                            color: white
                          ),
                        ),
                      ),
                      // Settings Btn
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
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}