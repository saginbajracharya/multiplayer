import 'package:cloud_firestore/cloud_firestore.dart';

class Lobby {
  final String name;
  final int maxPlayers;
  final int currentPlayers;
  final DateTime createdAt;
  final String gameMode;
  // Add other fields as needed

  Lobby({
    required this.name,
    required this.maxPlayers,
    required this.currentPlayers,
    required this.createdAt,
    required this.gameMode,
    // Add other fields as needed
  });

  factory Lobby.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Lobby(
      name: data['name'],
      maxPlayers: data['maxPlayers'],
      currentPlayers: data['currentPlayers'],
      createdAt: data['createdAt'].toDate(),
      gameMode: data['gameMode'],
      // Map other fields here
    );
  }
}
