import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiplayer/src/views/forgot_password_view/forgot_password.dart';
import 'package:multiplayer/src/views/login_view/loginout_controller.dart';
import 'package:multiplayer/src/views/signup_view/signup_view.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';
import 'package:multiplayer/src/widgets/animated_bg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginoutController loginCon = Get.put(LoginoutController());
  final loginformKey                = GlobalKey<FormState>();
  dynamic userCredential            = ''.obs;
  
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
          appbar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: white),
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.login,
              style: const TextStyle(color: white),
            ),
          ),
          child: Form(
            key: loginformKey,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    //Email
                    Flexible(
                      child: TextFormField(
                        controller: loginCon.email,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: white),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: black.withOpacity(0.8),
                          filled: true,
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
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
                          contentPadding: const EdgeInsets.only(bottom: 10.0, left: 16.0, right: 0.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    //Password
                    Flexible(
                      child: TextFormField(
                        obscureText: loginCon.showPassword,
                        controller: loginCon.password,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: white),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          fillColor: black.withOpacity(0.8),
                          filled: true,
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
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
                          contentPadding: const EdgeInsets.only(bottom: 10.0, left: 16.0, right: 0.0),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              setState(() {
                                loginCon.showPassword = !loginCon.showPassword;
                              });
                            },
                            icon: Icon(
                              loginCon.showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                              color: white,
                              size: 16.0,
                            )
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    //Forgot Password
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(ForgotPasswordView.routeName);
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          AppLocalizations.of(context)!.forgotPassword,
                          textAlign: TextAlign.right,
                          style: smallTextStyle,
                        )
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    //Login button
                    Flexible(
                      child: GetBuilder(
                        init: LoginoutController(),
                        builder: (_) {
                          return AButtonWidget(
                            btnText: AppLocalizations.of(context)!.login,
                            onPressed: () {
                              if (loginformKey.currentState!.validate() && loginCon.isProcessingLogin.value == false) {
                                loginCon.login();
                              }
                            },
                            child: loginCon.isProcessingLogin.value
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                            : Text(AppLocalizations.of(context)!.login,style: const TextStyle(color: white)),
                          );
                        }
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // login with Google or Facebook
                    Text(AppLocalizations.of(context)!.login),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Login with Google
                        Flexible(
                          child: GestureDetector(
                            onTap: () async{
                              userCredential.value = await loginCon.signInWithGoogle();
                              if (userCredential.value != null){
                                if (kDebugMode) {
                                  print(userCredential.value.user!.email);
                                }
                              }
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
                        const SizedBox(width: 10),
                        //Login with Facebook
                        Flexible(
                          child: GestureDetector(
                            onTap: () async{
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppLocalizations.of(context)!.dontHaveAccount),
                      const SizedBox(height: 10.0),
                      //Signup button
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(SignUpView.routeName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signup,
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
                                                                                                                                                                                                                                                                                                                                                    