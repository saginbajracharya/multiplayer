import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/views/hidden_view/hidden_view.dart';
import 'package:multiplayer/src/widgets/animated_bg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final InAppReview inAppReview = InAppReview.instance;
  String versionText = '';
  int tapCount = 1;

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
  
  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            //Theme
            InputDecorator(
              decoration: InputDecoration(
                fillColor: black.withOpacity(0.8),
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: white),
                  borderRadius : BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: white),
                  borderRadius : BorderRadius.all(Radius.circular(10.0)),
                ),
                disabledBorder:const OutlineInputBorder(
                  borderSide: BorderSide(color: white),
                  borderRadius : BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedErrorBorder:const OutlineInputBorder(
                  borderSide: BorderSide(color: white),
                  borderRadius : BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder:const OutlineInputBorder(
                  borderSide: BorderSide(color: white),
                  borderRadius : BorderRadius.all(Radius.circular(10.0)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: red),
                  borderRadius : BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  style: normalTextStyle,
                  alignment : AlignmentDirectional.center,
                  isExpanded: true,
                  isDense : true,
                  borderRadius:BorderRadius.circular(10.0),
                  dropdownColor: black.withOpacity(0.9),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: white,
                  ),
                  // Read the selected themeMode from the controller
                  value: widget.controller.themeMode,
                  // Call the updateThemeMode method any time the user selects a theme.
                  onChanged: widget.controller.updateThemeMode,
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('System Theme',style:normalTextStyle),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Light Theme',style:normalTextStyle),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Dark Theme',style:normalTextStyle),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            //Language
            InputDecorator(
              decoration: InputDecoration(
                fillColor: black.withOpacity(0.8),
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: white),
                  borderRadius : BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: white),
                  borderRadius : BorderRadius.all(Radius.circular(10.0)),
                ),
                disabledBorder:const OutlineInputBorder(
                  borderSide: BorderSide(color: white),
                  borderRadius : BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedErrorBorder:const OutlineInputBorder(
                  borderSide: BorderSide(color: white),
                  borderRadius : BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder:const OutlineInputBorder(
                  borderSide: BorderSide(color: white),
                  borderRadius : BorderRadius.all(Radius.circular(10.0)),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: red),
                  borderRadius : BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              child: DropdownButton<Locale>(
                value: widget.controller.currentLocale,
                isExpanded: true,
                isDense: true,
                underline: const SizedBox(),
                style: normalTextStyle,
                dropdownColor: black.withOpacity(0.9),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: white,
                ),
                items: AppLocalizations.supportedLocales.map((locale) {
                  return DropdownMenuItem<Locale>(
                    value: locale,
                    child: Text(
                      languageCodeToLocalization(locale.languageCode.toUpperCase(),context),
                      style:normalTextStyle
                    ),
                  );
                }).toList(),
                onChanged: (locale) {
                  if (locale != null) {
                    widget.controller.changeLocale(locale);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            //Rate Us
            GestureDetector(
              onTap: ()async{
                inAppReview.openStoreListing(appStoreId: 'com.dlofistudio.multiplayer');
              },
              child: Container(
                decoration:BoxDecoration(
                  color:black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                  border: Border.all(
                    color: white, // Border color
                    width: 1.0, // Border width
                  ),
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 14.0),
                child: Text(
                  AppLocalizations.of(context)!.rateus,
                  style: normalTextStyle
                ),
              ),
            ),
            const SizedBox(height: 20),
            //Share App
            GestureDetector(
              onTap: (){
                const appStoreLink = 'https://play.google.com/store/apps/details?id=com.dlofistudio.wallpapergallery';
                Share.share('Check out this awesome app!\n$appStoreLink');
              },
              child: Container(
                decoration:BoxDecoration(
                  color:black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                  border: Border.all(
                    color: white, // Border color
                    width: 1.0, // Border width
                  ),
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 14.0),
                child: Text(
                  AppLocalizations.of(context)!.shareApp,
                  style: normalTextStyle
                ),
              ),
            ),
            const SizedBox(height: 20),
            //Version
            GestureDetector(
              onTap: (){
                tapCount++;
                if(tapCount==10){
                  log('Unlocked Hidden Page');
                  tapCount = 0;
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: false,
                    useSafeArea: false,
                    isDismissible: false,
                    clipBehavior: Clip.none,
                    builder: (context) {
                      return HiddenView(versionText: versionText);
                    },
                  );
                }
              },
              child: Container(
                decoration:BoxDecoration(
                  color:black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                  border: Border.all(
                    color: white, // Border color
                    width: 1.0, // Border width
                  ),
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 14.0),
                child: FutureBuilder<String>(
                  future: getVersionNumber(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      versionText = snapshot.data!;
                      return Text(
                        '${AppLocalizations.of(context)!.version} ${snapshot.data!}',
                        style: normalTextStyle
                      );
                    } else {
                      return const Text('',style: TextStyle(color: white));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

languageCodeToLocalization(locale,context){
  if(locale=='EN'){
    return AppLocalizations.of(context)!.en;
  }
  else if(locale == "ES"){
    return AppLocalizations.of(context)!.es;
  }
  else if(locale == "HI"){
    return AppLocalizations.of(context)!.hi;
  }
  else if(locale == "NE"){
    return AppLocalizations.of(context)!.ne;
  }
}