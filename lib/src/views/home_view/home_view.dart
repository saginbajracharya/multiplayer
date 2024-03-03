import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/constant.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';
import 'package:multiplayer/src/views/level_view/level_1.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_view.dart';
import 'package:multiplayer/src/views/login_view/login_view.dart';
import 'package:multiplayer/src/views/login_view/loginout_controller.dart';
import 'package:multiplayer/src/views/signup_view/signup_view.dart';
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
            const LogoWidget(),
            const SizedBox(width: double.infinity),
            // Profile
            const Column(
              children: [
                Center(
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
                  padding: EdgeInsets.symmetric(vertical:10),
                  child: Text(
                    'PLAYER 1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(width: double.infinity),
            // Play Buttons
            Obx(()=> 
              homeCon.isUserLoggedIn.value
              ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //MULTIPLAYER Play Button
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
                    child: ElevatedButton(
                      onPressed: () async{
                        Get.to(const LobbyView());
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: white),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return green.withOpacity(0.8); // Disabled color
                            }
                            return green.withOpacity(0.8); // Regular color
                          },
                        ),
                      ),
                      child: const Text('MULTIPLAYER'),
                    ),
                  ),
                  //SOLO Play Button
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
                    child: ElevatedButton(
                      onPressed: () async{
                        Get.to(const Level1());
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: white),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return green.withOpacity(0.8); // Disabled color
                            }
                            return green.withOpacity(0.8); // Regular color
                          },
                        ),
                      ),
                      child: const Text('SOLO PLAY'),
                    ),
                  ),
                  // LOGOUT
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
                    child: ElevatedButton(
                      onPressed: () async{
                        loginoutCon.logout();
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: white),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return green.withOpacity(0.8); // Disabled color
                            }
                            return green.withOpacity(0.8); // Regular color
                          },
                        ),
                      ),
                      child: const Text('LOGOUT'),
                    ),
                  ),
                ],
              )
              : Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
                    child: ElevatedButton(
                      onPressed: () async{
                        Get.to(const LoginView());
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: white),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return green.withOpacity(0.8); // Disabled color
                            }
                            return green.withOpacity(0.8); // Regular color
                          },
                        ),
                      ),
                      child: const Text('LOGIN'),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
                    child: ElevatedButton(
                      onPressed: () async{
                        Get.to(const SignUpView());
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: white),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return green.withOpacity(0.8); // Disabled color
                            }
                            return green.withOpacity(0.8); // Regular color
                          },
                        ),
                      ),
                      child: const Text('REGISTER'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: double.infinity),
          ],
        )
      ),
    );
  }
}