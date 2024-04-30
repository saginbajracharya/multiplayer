import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/constant.dart';
import 'package:multiplayer/src/services/firestore_services.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/models/lobby_model.dart';
import 'package:multiplayer/src/models/user_model.dart';
import 'package:multiplayer/src/views/level_view/level.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_detail_view/lobby_detail_controller.dart';

class LobbyDetailView extends StatefulWidget {
  const LobbyDetailView({super.key, this.lobbyData});

  final Lobby? lobbyData;
  
  static const routeName = '/lobby_detail_view';

  @override
  State<LobbyDetailView> createState() => _LobbyDetailViewState();
}

class _LobbyDetailViewState extends State<LobbyDetailView> {
  final LobbyDetailController lobbyDetailCon = Get.put(LobbyDetailController());
  dynamic currentUserEmail;
  dynamic currentUserDetails;
  bool currentUserReadyStatus = false;

  @override
  void initState() {
    super.initState();
    getLoggedInUserEmail();
  }

  getLoggedInUserEmail()async{
    currentUserEmail = await read(StorageKeys.emailKey);
    FirestoreServices.updateUserInLobby(true, currentUserEmail, false, widget.lobbyData!.name);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: false,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: Text(widget.lobbyData!.name),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: GetBuilder(
            init: LobbyDetailController(),
            builder: (context) {
              return StreamBuilder<List<UserFireBase>>(
                stream: FirestoreServices.listPlayersInLobby(widget.lobbyData!.name), 
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('${AppLocalizations.of(context)!.error}: ${snapshot.error}'));
                  }
                  else{
                    final lobbyUsers = snapshot.data;
                    currentUserEmail = read(StorageKeys.emailKey);
                    currentUserDetails = lobbyUsers.firstWhere(
                      (user) => user.email == currentUserEmail,
                    );
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //Players List
                        GridView.builder(
                          itemCount: lobbyUsers.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            final user = lobbyUsers[index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    //Player Image
                                    Image.network(
                                      AppDefaultValues.ramndomImage,
                                      fit: BoxFit.fill,
                                    ),
                                    //Email
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      alignment: Alignment.bottomCenter,
                                      decoration: BoxDecoration(
                                        color: transparent.withOpacity(0.5),
                                      ),
                                      child: Text(user.email),
                                    ),
                                    currentUserEmail==user.email
                                    ?Text(AppLocalizations.of(context)!.you)
                                    :const SizedBox(),
                                    //Ready Indicator
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: user.readyStatus?green:red,
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Text(
                                          user.readyStatus?AppLocalizations.of(context)!.ready:AppLocalizations.of(context)!.notReady,
                                          style: const TextStyle(color: white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Column(
                          children: [
                            //Ready Button
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
                              child: ElevatedButton(
                                onPressed: () async{
                                  if (currentUserDetails.readyStatus==true) {
                                    lobbyDetailCon.updateUserReadyStatus(currentUserEmail, false);
                                    FirestoreServices.updateUserInLobby(true, currentUserEmail, false, widget.lobbyData!.name);
                                  }
                                  else{
                                    lobbyDetailCon.updateUserReadyStatus(currentUserEmail, true);
                                    FirestoreServices.updateUserInLobby(true, currentUserEmail, true, widget.lobbyData!.name);
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
                                child: lobbyDetailCon.isUpdatingReady.value 
                                ?const Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator()
                                  )
                                )
                                :Text(AppLocalizations.of(context)!.ready),
                              ),
                            ),
                            //Play Button
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
                              child: ElevatedButton(
                                onPressed: () async{
                                  Get.to(()=>const Level());
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
                                child: lobbyDetailCon.isUpdatingReady.value 
                                ?const Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator()
                                  )
                                )
                                :Text(AppLocalizations.of(context)!.play),
                              ),
                            ),
                            //Leave Button
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
                              child: ElevatedButton(
                                onPressed: () async{
                                  FirestoreServices.updateUserInLobby(false, currentUserEmail, false, widget.lobbyData!.name).then((value){
                                    Get.back();
                                  });
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
                                child: lobbyDetailCon.isUpdatingReady.value 
                                ?const Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator()
                                  )
                                )
                                :const Text('Leave'),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  }
                }
              );
            }
          ),
        ),
      ),
    );
  }
}