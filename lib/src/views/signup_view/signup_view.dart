import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiplayer/src/views/signup_view/signup_controller.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';
import 'package:multiplayer/src/widgets/animated_bg.dart';
import 'package:multiplayer/src/widgets/logo_widget.dart';
import '../../common/styles.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  static const routeName = '/signup';
  
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpController signUpCon = Get.put(SignUpController());
  final signupformKey       = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BackgroundScaffold(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: signupformKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.width/5),
                      const LogoWidget(seconds: 0),
                      const SizedBox(height: 50.0),
                      //name
                      TextFormField(
                        controller: signUpCon.name,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: white),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          fillColor: black.withOpacity(0.8),
                          filled: true,
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
                        style: const TextStyle(color: white),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: black.withOpacity(0.8),
                          filled: true,
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
                        style: const TextStyle(color: white),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          fillColor: black.withOpacity(0.8),
                          filled: true,
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
                      //Signup Button
                      GetBuilder(
                        init: SignUpController(),
                        builder: (_) {
                          return AButtonWidget(
                            btnText: AppLocalizations.of(context)!.signup, 
                            onPressed: (){
                              if(signupformKey.currentState!.validate()){
                                signUpCon.signup();
                              }
                            },
                            child: signUpCon.isProcessingSignup.value 
                            ?const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator()
                            )
                            :Text(AppLocalizations.of(context)!.signup,style: const TextStyle(color: white)),
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