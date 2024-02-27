import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiplayer/src/views/signup_view/signup_controller.dart';
import '../../common/styles.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  static const routeName = '/signup';
  
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpController signUpCon = Get.put(SignUpController());
  double opacity = 0.0;

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
      canPop: true,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          extendBody: false,
          extendBodyBehindAppBar: false,
          resizeToAvoidBottomInset:true,
          appBar: AppBar(
            // title: Text(AppLocalizations.of(context)!.login),
            centerTitle: true,
            automaticallyImplyLeading: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: signUpCon.signupformKey,
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
                      const SizedBox(height: 50.0),
                      //name
                      TextFormField(
                        controller: signUpCon.name,
                        textAlign: TextAlign.start,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
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
                          hintText: AppLocalizations.of(context)!.name,
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
                      //email
                      TextFormField(
                        controller: signUpCon.email,
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
                      //password
                      TextFormField(
                        obscureText: signUpCon.showPassword,
                        controller: signUpCon.password,
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
                                if(signUpCon.showPassword==true){
                                  signUpCon.showPassword=false;
                                }
                                else{
                                  signUpCon.showPassword=true;
                                }
                              });
                            },
                            icon: Icon(
                              signUpCon.showPassword ? Icons.visibility_off : Icons.visibility,
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
                        init: SignUpController(),
                        builder: (context) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if(signUpCon.signupformKey.currentState!.validate()){
                                  signUpCon.signup();
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
                              child: signUpCon.isProcessingSignup.value 
                              ?const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator()
                                )
                              )
                              :const Text('Register'),
                            ),
                          );
                        }
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