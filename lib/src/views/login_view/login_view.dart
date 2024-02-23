import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/views/login_view/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const routeName = '/';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController loginCon = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: loginCon.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
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
                        hintText: 'Username/Email',
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
                        hintText: 'Password',
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
                    const SizedBox(height: 16.0),
                    GetBuilder(
                      init: LoginController(),
                      builder: (context) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if(loginCon.formKey.currentState!.validate()){
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
                                    return grey; // Disabled color
                                  }
                                  return grey; // Regular color
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
                                                                                                                                                                                                                                                                                                                                                    