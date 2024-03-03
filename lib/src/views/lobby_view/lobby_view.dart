import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/firestore_service.dart';
import 'package:multiplayer/src/models/lobby_model.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_controller.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_detail_view/lobby_detail_view.dart';
import 'package:multiplayer/src/views/lobby_view/lobby_form_view/lobby_form_view.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';

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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AButtonWidget(
                  btnText: 'CREATE', 
                  onPressed: () {  
                    Get.to(()=>const LobbyForm());
                  },
                ),
                StreamBuilder<List<Lobby>>(
                  stream: FirestoreServices.streamLobbies(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var lobbies = snapshot.data!;
                      return ListView.builder(
                        itemCount: lobbies.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var lobby = lobbies[index];
                          var gradientColors = getRandomGradientColors();
                          return GestureDetector(
                            onTap: (){
                              Get.to(()=>const LobbyDetailView());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: gradientColors,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: ListTile(
                                title: Text(lobby.name, style: const TextStyle(color: white)),
                                subtitle: Text(
                                  'Players: ${lobby.currentPlayers}/${lobby.maxPlayers}',
                                  style: const TextStyle(color: white),
                                ),
                                // Add other UI elements as needed
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}