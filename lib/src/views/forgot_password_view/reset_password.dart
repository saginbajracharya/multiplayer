import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/views/forgot_password_view/forgot_password_controller.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';
import 'package:multiplayer/src/widgets/animated_bg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  static const routeName = '/resetPassword';

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final ForgotPasswordController forgotPassCon = Get.put(ForgotPasswordController());
  final resetPassKey                           = GlobalKey<FormState>();
  
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
            key: resetPassKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 20),
                //Email
                Flexible(
                  child: TextFormField(
                    controller: forgotPassCon.email,
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
                //Token
                Flexible(
                  child: TextFormField(
                    controller: forgotPassCon.token,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: white),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
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
                      hintText: AppLocalizations.of(context)!.tokenHintTxt,
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
                    obscureText: forgotPassCon.showPassword,
                    controller: forgotPassCon.password,
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
                            forgotPassCon.showPassword = !forgotPassCon.showPassword;
                          });
                        },
                        icon: Icon(
                          forgotPassCon.showPassword
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
                const SizedBox(height: 20.0),
                //Reset Password Call Api Button
                Flexible(
                  child: GetBuilder(
                    init: ForgotPasswordController(),
                    builder: (_) {
                      return AButtonWidget(
                        btnText: AppLocalizations.of(context)!.resetPassword,
                        onPressed: () {
                          if (resetPassKey.currentState!.validate() && forgotPassCon.isProcessingResetPass.value == false) {
                            forgotPassCon.resetPassword();
                          }
                        },
                        child: forgotPassCon.isProcessingResetPass.value
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                        : Text(AppLocalizations.of(context)!.resetPassword,style: const TextStyle(color: white)),
                      );
                    }
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