import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiplayer/src/views/login_view/login_view.dart';
import 'package:multiplayer/src/views/signup_view/signup_controller.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';
import 'package:multiplayer/src/widgets/animated_bg.dart';
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
          appbar:AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: white),
            centerTitle: true,
            title: Text(AppLocalizations.of(context)!.signup,style: const TextStyle(color:white)),
          ),
          child: Form(
            key: signupformKey,
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
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
                            errorStyle: const TextStyle(
                              fontSize: 0,
                              height: 0
                            ),
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
                            errorStyle: const TextStyle(
                              fontSize: 0,
                              height: 0
                            ),
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
                            errorStyle: const TextStyle(
                              fontSize: 0,
                              height: 0
                            ),
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
                        ),
                        const SizedBox(height: 20.0),
                        Text(AppLocalizations.of(context)!.signupwith),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Login with Google
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: white,
                                      width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.all(4.0),
                                  child: const Icon(
                                    Icons.g_mobiledata,
                                    size: 40,
                                  )
                                )
                              ),
                            ),
                            const SizedBox(width:10),
                            //Login with Facebook
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: white,
                                      width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: const EdgeInsets.all(4.0),
                                  child: const Icon(
                                    Icons.facebook,
                                    size: 40,
                                  )
                                )
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppLocalizations.of(context)!.haveAccount),
                      const SizedBox(height: 10.0),
                      //Login button
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(LoginView.routeName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: const TextStyle(color: white),
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}