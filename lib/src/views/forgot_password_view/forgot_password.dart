import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiplayer/src/views/forgot_password_view/forgot_password_controller.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';
import 'package:multiplayer/src/widgets/animated_bg.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  static const routeName = '/forgotPassword';

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordController forgotPassCon = Get.put(ForgotPasswordController());
  final forgotPassEmailKey                     = GlobalKey<FormState>();
  
  @override
  void initState() {
    forgotPassCon.email.clear();
    forgotPassCon.token.clear();
    forgotPassCon.password.clear();
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
              AppLocalizations.of(context)!.forgotPassword,
              style: const TextStyle(color: white),
            ),
          ),
          child: Form(
            key: forgotPassEmailKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    AppLocalizations.of(context)!.passwordResetMsgTxt,
                    style: normalTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20.0),
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
                const SizedBox(height: 20.0),
                //Request Password Reset Token Button
                Flexible(
                  child: GetBuilder(
                    init: ForgotPasswordController(),
                    builder: (_) {
                      return AButtonWidget(
                        btnText: AppLocalizations.of(context)!.reqPassResetTokenBtnTxt,
                        onPressed: () {
                          if (forgotPassEmailKey.currentState!.validate() && forgotPassCon.isProcessingReqToken.value == false) {
                            forgotPassCon.requestRestPassToken();
                          }
                        },
                        child: forgotPassCon.isProcessingReqToken.value
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                        : Text(AppLocalizations.of(context)!.reqPassResetTokenBtnTxt,style: const TextStyle(color: white)),
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
                                                                                                                                                                                                                                                                                                                                                    