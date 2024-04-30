import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/services/firestore_services.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LobbyForm extends StatefulWidget {
  const LobbyForm({super.key});

  static const routeName = '/lobby_view';

  @override
  State<LobbyForm> createState() => _LobbyFormState();
}

class _LobbyFormState extends State<LobbyForm> {
  final HomeController homeCon = Get.put(HomeController());
  final _formKey = GlobalKey<FormState>();
  String _lobbyName = '';
  int _maxPlayers = 2;
  String _gameMode = 'Team Deathmatch';
  String _gameMap = 'Map 1';
  String _lobbyType = 'Public';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.createLobby,
          )
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //Lobby Name
                  TextFormField(
                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.lobbyName),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.lobbyNameEmptyError;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _lobbyName = value!;
                    },
                  ),
                  //Max Players
                  DropdownButtonFormField<int>(
                    value: _maxPlayers,
                    items: <DropdownMenuItem<int>>[
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text(AppLocalizations.of(context)!.max2player),
                      ),
                      DropdownMenuItem<int>(
                        value: 4,
                        child: Text(AppLocalizations.of(context)!.max4player),
                      ),
                      DropdownMenuItem<int>(
                        value: 6,
                        child: Text(AppLocalizations.of(context)!.max6player),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _maxPlayers = value!;
                      });
                    },
                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.maxPlayers),
                  ),
                  //Game Mode
                  DropdownButtonFormField<String>(
                    value: _gameMode,
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: AppLocalizations.of(context)!.deathMode,
                        child: Text(AppLocalizations.of(context)!.deathMode),
                      ),
                      DropdownMenuItem<String>(
                        value: AppLocalizations.of(context)!.brawlMode,
                        child: Text(AppLocalizations.of(context)!.brawlMode),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _gameMode = value!;
                      });
                    },
                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.gameMode),
                  ),
                  //Game Map
                  DropdownButtonFormField<String>(
                    value: _gameMap,
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: AppLocalizations.of(context)!.map1,
                        child: Text(AppLocalizations.of(context)!.map1),
                      ),
                      DropdownMenuItem<String>(
                        value: AppLocalizations.of(context)!.map2,
                        child: Text(AppLocalizations.of(context)!.map2),
                      ),
                      DropdownMenuItem<String>(
                        value: AppLocalizations.of(context)!.map3,
                        child: Text(AppLocalizations.of(context)!.map3),
                      ),
                      DropdownMenuItem<String>(
                        value: AppLocalizations.of(context)!.map4,
                        child: Text(AppLocalizations.of(context)!.map4),
                      ),
                      DropdownMenuItem<String>(
                        value: AppLocalizations.of(context)!.map5,
                        child: Text(AppLocalizations.of(context)!.map5),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _gameMap = value!;
                      });
                    },
                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.gameMap),
                  ),
                  //Privacy/lobby Type
                  DropdownButtonFormField<String>(
                    value: _lobbyType,
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: AppLocalizations.of(context)!.publicMode,
                        child: Text(AppLocalizations.of(context)!.publicMode),
                      ),
                      DropdownMenuItem<String>(
                        value: AppLocalizations.of(context)!.privateMode,
                        child: Text(AppLocalizations.of(context)!.privateMode),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _lobbyType = value!;
                      });
                    },
                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.lobbyType),
                  ),
                  const SizedBox(height: 50),
                  AButtonWidget(
                    btnText: AppLocalizations.of(context)!.submitBtnText, 
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FirestoreServices.createLobby(
                          _lobbyName, 
                          _maxPlayers,
                          _gameMode,
                          _gameMap,
                          _lobbyType, 
                          homeCon.username.value
                        ).then((value) => Get.back());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
