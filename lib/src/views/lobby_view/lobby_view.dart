import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/firestore_service.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/models/user_model.dart';
import 'package:multiplayer/src/views/level_view/level_1.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_controller.dart';

class LobbyView extends StatefulWidget {
  const LobbyView({super.key});

  static const routeName = '/lobby_view';

  @override
  State<LobbyView> createState() => _LobbyViewState();
}

class _LobbyViewState extends State<LobbyView> {
  final LobbyController lobbyCon = Get.put(LobbyController());
  dynamic currentUserEmail;
  dynamic currentUserDetails;
  bool currentUserReadyStatus = false;

  @override
  void initState() {
    super.initState();
    lobbyCon.getAllUsers();
  }
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        extendBody: false,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: const Text('Lobby'),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: GetBuilder(
          init: LobbyController(),
          builder: (context) {
            return lobbyCon.isProcessingAllUsers.value
            ?const Center(child: CircularProgressIndicator())
            :StreamBuilder<List<UserFireBase>>(
              stream: FirestoreServices.getAllOnlineUsers(), 
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                else{
                  final onlineUsers = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //Players List
                      GridView.builder(
                        itemCount: onlineUsers.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemBuilder: (context, index) {
                          final user = onlineUsers[index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  //Player Image
                                  Image.network(
                                    'https://picsum.photos/200?random=${100}',
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
                                  //Ready Indicator
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color: user.isReady?green:red,
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Text(
                                        user.isReady?'Ready':'Not Ready',
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
                                currentUserEmail = await read(StorageKeys.email);
                                currentUserDetails = onlineUsers.firstWhere(
                                  (user) => user.email == currentUserEmail,
                                );
                                if (currentUserDetails.isReady) {
                                  lobbyCon.updateUserReadyStatus(currentUserEmail, false);
                                }
                                else{
                                  lobbyCon.updateUserReadyStatus(currentUserEmail, true);
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
                              child: lobbyCon.isUpdatingReady.value 
                              ?const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator()
                                )
                              )
                              :const Text('Ready'),
                            ),
                          ),
                          //Play Button
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
                            child: ElevatedButton(
                              onPressed: () async{
                                Get.to(const Level1());
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
                              child: lobbyCon.isUpdatingReady.value 
                              ?const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator()
                                )
                              )
                              :const Text('Play'),
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
    );
  }
}