import 'package:flutter/material.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/widgets/animated_bg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

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
                  value: controller.themeMode,
                  // Call the updateThemeMode method any time the user selects a theme.
                  onChanged: controller.updateThemeMode,
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('System Theme'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Light Theme'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Dark Theme'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                value: controller.currentLocale,
                isExpanded: true,
                isDense: true,
                underline: const SizedBox(),
                dropdownColor: black.withOpacity(0.9),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: white,
                ),
                items: AppLocalizations.supportedLocales.map((locale) {
                  return DropdownMenuItem<Locale>(
                    value: locale,
                    child: Text(languageCodeToLocalization(locale.languageCode.toUpperCase(),context)),
                  );
                }).toList(),
                onChanged: (locale) {
                  if (locale != null) {
                    controller.changeLocale(locale);
                  }
                },
              ),
            ),
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