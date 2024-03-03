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
import 'package:multiplayer/src/views/signup_view/signup_view.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';
import 'package:multiplayer/src/widgets/logo_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/home_view';

  @override
  State<HomeView> createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {
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
      child: Scaffold(
        extendBody: false,
        extendBodyBehindAppBar: true,
        body: Column(
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
                      radius: 40.0,
                      backgroundColor: transparent,
                      backgroundImage: NetworkImage(profilePlaceHolder),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:10),
                  child: Obx(()=>
                    Text(
                      homeCon.username.value!=""?homeCon.username.value:'PLAYER 1',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
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
                    btnText: 'MULTIPLAYER', 
                    onPressed:() async{
                      Get.to(const LobbyView());
                    },
                  ),
                  //SOLO Play Button
                  AButtonWidget(
                    btnText: 'SOLO PLAY', 
                    onPressed:() async{
                      Get.to(const Level1());
                    },
                  ),
                  // LOGOUT
                  AButtonWidget(
                    btnText: 'LOGOUT', 
                    onPressed:() async{
                      loginoutCon.logout();
                    },
                  ),
                ],
              )
              : Column(
                children: [
                  AButtonWidget(
                    btnText: 'LOGIN', 
                    onPressed:() async{
                      Get.to(const LoginView());
                    },
                  ),
                  AButtonWidget(
                    btnText: 'REGISTER', 
                    onPressed:() async{
                      Get.to(const SignUpView());
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: double.infinity),
            //Audio On/Off Icon_Button
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
                :Icons.music_off
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}