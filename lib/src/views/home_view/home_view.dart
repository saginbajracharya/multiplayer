import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/services/audio_services.dart';
import 'package:multiplayer/src/common/constant.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';
import 'package:multiplayer/src/views/level_view/level.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_view.dart';
import 'package:multiplayer/src/views/login_view/login_view.dart';
import 'package:multiplayer/src/views/login_view/loginout_controller.dart';
import 'package:multiplayer/src/views/settings/settings_view.dart';
import 'package:multiplayer/src/views/signup_view/signup_view.dart';
import 'package:multiplayer/src/views/store_view/store_view.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiplayer/src/widgets/animated_bg.dart';
import 'package:multiplayer/src/widgets/exit_dialog.dart';
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
  bool isExitDialogShown = false;
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    homeCon.getUserName();
    homeCon.getProfilePic();
    homeCon.getUserTotalCoin();
    homeCon.getUserTotalGem();
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
      onPopInvoked: (bool didPop){
        showDialog(
          context: context,
          barrierDismissible: false,
          useRootNavigator: true,
          builder: (BuildContext context) => ExitDialog(
            okCallback: () { 
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
          )
        );
      },
      child: UpgradeAlert(
        upgrader: Upgrader(
          countryCode            : AppDefaultValues.upgraderCountryCode,
          debugDisplayAlways     : false,
          debugDisplayOnce       : false,
          debugLogging           : false,
          durationUntilAlertAgain: Duration.zero,
          minAppVersion          : AppDefaultValues.upgradeMinAppVersion
        ),
        child: BackgroundScaffold( 
          padding: const EdgeInsets.only(
            top: kToolbarHeight
          ),
          child: UpgradeAlert(
            upgrader: Upgrader(
              debugDisplayAlways     : false,
              durationUntilAlertAgain: Duration.zero,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Title
                const Positioned(
                  top: kToolbarHeight+20,
                  child: LogoWidget(seconds: 1)
                ),
                // Center User Details
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Profile
                      Obx(()=> 
                        homeCon.isUserLoggedIn.value
                        ?Center(
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: gold,
                            child: CircleAvatar(
                              radius: 46.0,
                              backgroundColor: grey,
                              backgroundImage: NetworkImage(homeCon.userProfilePic.value!=""?"$baseUploadsImageUrl${homeCon.userProfilePic.value}":profilePlaceHolder),
                            ),
                          ),
                        )
                        :const Center(
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
                      ),
                      // Name
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:20),
                        child: Obx(()=>
                          Text(
                            homeCon.username.value!="" && homeCon.isUserLoggedIn.value
                            ?homeCon.username.value
                            :AppLocalizations.of(context)!.player1,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: white
                            ),
                          ),
                        ),
                      ),
                      // Coin & Gems
                      Obx(()=>
                        homeCon.isUserLoggedIn.value
                        ? Column(
                          children: [
                            //Coin
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  width: 40,
                                  height: 40,
                                  AssetImages.coinIconImage,
                                ),
                                const SizedBox(width: 5.0),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      height: 30,
                                      AssetImages.coinUIContainer,
                                    ),
                                    Text(
                                      homeCon.userTotalCoin.value!=""
                                      ?homeCon.userTotalCoin.value
                                      :'0',
                                      style: normalTextStyleBlack
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            //Gem
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  width: 40,
                                  height: 40,
                                  AssetImages.gemIconImage,
                                ),
                                const SizedBox(width: 5.0),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      height: 30,
                                      AssetImages.gemUIContainer,
                                    ),
                                    Text(
                                      homeCon.userTotalGem.value!=""
                                      ?homeCon.userTotalGem.value
                                      :'0',
                                      style: normalTextStyleBlack
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                        :const SizedBox(),
                      )
                    ],
                  ),
                ),
                // Play/Login Buttons
                Positioned(
                  bottom: kBottomNavigationBarHeight,
                  left: 0,
                  right: 0,
                  child: Obx(()=> 
                    homeCon.isUserLoggedIn.value
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //MULTIPLAYER Play Button
                        GestureDetector(
                          onTap:() async{
                            Get.toNamed(
                              LobbyView.routeName,
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/2,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [red.withOpacity(0.5), red.withOpacity(0.8)],
                              ),
                              border: Border(
                                top: BorderSide(color: red.withOpacity(0.8), width: 2),
                                bottom: BorderSide(color: red.withOpacity(0.8), width: 2),
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Text(AppLocalizations.of(context)!.multiplayerMode,style:normalTextStyle)
                          )
                        ),
                        //SOLO Play Button
                        GestureDetector(
                          onTap:() async{
                            Get.toNamed(Level.routeName);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/2,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [blue.withOpacity(0.5), blue.withOpacity(0.8)],
                              ),
                              border: Border(
                                top: BorderSide(color: blue.withOpacity(0.8), width: 2),
                                bottom: BorderSide(color: blue.withOpacity(0.8), width: 2),
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Text(AppLocalizations.of(context)!.soloMode,style:normalTextStyle),
                          )
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
                ),
                //Audio On/Off Icon_Button,settings,logout,store
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetBuilder(
                        init: LoginoutController(),
                        builder: (_) {
                          return homeCon.isUserLoggedIn.value
                          ?IconButton(
                            icon: const Icon(Icons.store), 
                            onPressed:() async{
                              Get.toNamed(StoreView.routeName);
                            },
                          )
                          :const SizedBox();
                        }
                      ),
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
                      //Logout
                      Obx(()=> homeCon.isUserLoggedIn.value
                        ?IconButton(
                          icon: const Icon(Icons.power_settings_new), 
                          onPressed:() async{
                            if(loginoutCon.isProcessingLogout.value==false){
                              loginoutCon.logout();
                            }
                          },
                        )
                        :const SizedBox(),
                      )
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