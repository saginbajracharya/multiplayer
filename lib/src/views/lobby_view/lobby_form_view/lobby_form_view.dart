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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const SizedBox(height: 50),
                AButtonWidget(
                  btnText: 'Submit', 
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      FirestoreServices.createLobby(_lobbyName, _maxPlayers, homeCon.username.value).then((value) => Get.back());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
