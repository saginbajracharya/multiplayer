import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/firestore_service.dart';
import 'package:multiplayer/src/views/home_view/home_controller.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';

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
          title: const Text(
            'Create Lobby',
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
                    decoration: const InputDecoration(labelText: 'Lobby Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a lobby name';
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
                    items: const <DropdownMenuItem<int>>[
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text('2 Players'),
                      ),
                      DropdownMenuItem<int>(
                        value: 4,
                        child: Text('4 Players'),
                      ),
                      DropdownMenuItem<int>(
                        value: 6,
                        child: Text('6 Players'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _maxPlayers = value!;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Max Players'),
                  ),
                  //Game Mode
                  DropdownButtonFormField<String>(
                    value: _gameMode,
                    items: const <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: 'Team Deathmatch',
                        child: Text('Team Deathmatch'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Brawl',
                        child: Text('Brawl'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _gameMode = value!;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Game Mode'),
                  ),
                  //Game Map
                  DropdownButtonFormField<String>(
                    value: _gameMap,
                    items: const <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: 'Map 1',
                        child: Text('Map 1'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Map 2',
                        child: Text('Map 2'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Map 3',
                        child: Text('Map 3'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Map 4',
                        child: Text('Map 4'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Map 5',
                        child: Text('Map 5'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _gameMap = value!;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Game Map'),
                  ),
                  //Privacy/lobby Type
                  DropdownButtonFormField<String>(
                    value: _lobbyType,
                    items: const <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: 'Public',
                        child: Text('Public'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Private',
                        child: Text('Private'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _lobbyType = value!;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Lobby Type'),
                  ),
                  const SizedBox(height: 50),
                  AButtonWidget(
                    btnText: 'Submit', 
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
