import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiplayer/src/views/login_view/loginout_controller.dart';
import 'package:multiplayer/src/views/signup_view/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginoutController loginCon = Get.put(LoginoutController());
  final loginformKey                = GlobalKey<FormState>();
  double opacity                    = 0.0;
  
  @override
  void initState() {
    super.initState();
    // Start the animation
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
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          extendBody: false,
          extendBodyBehindAppBar: false,
          resizeToAvoidBottomInset:true,
          appBar: AppBar(
            // title: Text(AppLocalizations.of(context)!.login),
            centerTitle: true,
            automaticallyImplyLeading: false,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: loginformKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.width/5),
                      AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(seconds: 2),
                        child: Text(
                          AppLocalizations.of(context)!.appTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30.0, // Adjust the font size as needed
                            fontWeight: FontWeight.bold, // Make the text bold
                            letterSpacing: 5,
                            wordSpacing: 5,
                            shadows: [
                              Shadow(
                                blurRadius: 4.0,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 100.0),
                      TextFormField(
                        controller: loginCon.email,
                        textAlign: TextAlign.start,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0.01),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: white)
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: white)
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: red)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: red)
                          ), 
                          filled: true,
                          hintText: AppLocalizations.of(context)!.email,
                          hintStyle: const TextStyle(color: grey),
                          contentPadding: const EdgeInsets.only(
                            bottom: 10.0, 
                            left: 16.0, 
                            right: 0.0
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        obscureText: loginCon.showPassword,
                        controller: loginCon.password,
                        textAlign: TextAlign.start,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0.01),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: white)
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: white)
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: red)
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: red)
                          ), 
                          filled: true,
                          hintText: AppLocalizations.of(context)!.password,
                          hintStyle: const TextStyle(color: grey),
                          contentPadding: const EdgeInsets.only(
                            bottom: 10.0, 
                            left: 16.0, 
                            right: 0.0
                          ),
                          suffixIcon: IconButton(
                            onPressed: ()  async{
                              setState(() {
                                if(loginCon.showPassword==true){
                                  loginCon.showPassword=false;
                                }
                                else{
                                  loginCon.showPassword=true;
                                }
                              });
                            },
                            icon: Icon(
                              loginCon.showPassword ? Icons.visibility_off : Icons.visibility,
                              color: white,
                              size: 16.0,
                            ) 
                          )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      GetBuilder(
                        init: LoginoutController(),
                        builder: (context) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if(loginformKey.currentState!.validate()){
                                  loginCon.login();
                                }
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
                              child: loginCon.isProcessingLogin.value 
                              ?const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator()
                                )
                              )
                              :const Text('Login'),
                            ),
                          );
                        }
                      ),
                      const SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(SignUpView.routeName);
                        },
                        child: const Text('Register')
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
                                                                                                                                                                                                                                                                                                                                                    