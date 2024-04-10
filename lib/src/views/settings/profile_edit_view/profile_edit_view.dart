import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/constant.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';
import 'package:multiplayer/src/widgets/animated_bg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';
import 'package:multiplayer/src/views/settings/profile_edit_view/profile_edit_controller.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({super.key});

  static const routeName = '/profile_edit_view';

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final ProfileEditController profileEditCon = Get.put(ProfileEditController());
  final HomeController homeCon               = Get.put(HomeController());
  final profileEditKey                       = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    profileEditCon.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BackgroundScaffold(
        appbar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: white),
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.editProfile,style: const TextStyle(color:white)),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: profileEditKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: kBottomNavigationBarHeight),
                //Profile Pic
                InkWell(
                  onTap: () {
                    if (!profileEditCon.isProcessingSave.value) {
                      profileEditCon.pickProfileImages();
                    }
                  },
                  child: Obx(() => ClipOval(
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      color: gold,
                      child: profileEditCon.selectedProfileImage.value != null
                      ? Image.file(
                        File(profileEditCon.selectedProfileImage.value!.path),
                        fit: BoxFit.cover,
                      )
                      : CircleAvatar(
                        radius: 46.0,
                        backgroundColor: grey,
                        backgroundImage: NetworkImage(
                          homeCon.userProfilePic.value != ""
                          ? "$baseUploadsImageUrl${homeCon.userProfilePic.value}"
                          : profilePlaceHolder,
                        ),
                      ),
                    ),
                  )),
                ),
                const SizedBox(height: 20.0),
                //name
                TextFormField(
                  controller: profileEditCon.name,
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
                  controller: profileEditCon.email,
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
                const SizedBox(height: 30.0),
                //Save Button
                GetBuilder(
                  init: ProfileEditController(),
                  builder: (_) {
                    return AButtonWidget(
                      btnText: AppLocalizations.of(context)!.yes, 
                      onPressed: (){
                        if(profileEditKey.currentState!.validate()){
                          profileEditCon.editProfile();
                        }
                      },
                      child: profileEditCon.isProcessingSave.value 
                      ?const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator()
                      )
                      :Text(AppLocalizations.of(context)!.save,style: const TextStyle(color: white)),
                    );
                  }
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}