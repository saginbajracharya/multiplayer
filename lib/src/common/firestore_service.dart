import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:multiplayer/src/models/lobby_model.dart';

import '../models/user_model.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class FirestoreServices {
  double uploadProgress = 0;

  // Sign In Anonymously
  static Future<bool> logInAnonymously(String username, String email) async {
    try {
      var success = await FirebaseAuth.instance.signInAnonymously();
      if (kDebugMode) {
        print(success.toString());
      }
      return true;
    } on FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return false;
    }
  }

  //List All Online Users
  static Stream<List<UserFireBase>> getAllOnlineUsers() {
    return FirebaseFirestore.instance
    .collection('users')
    .where('isOnline', isEqualTo: true)
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => UserFireBase.fromSnapshot(doc)).toList());
  }

  // Update user's online status and add user if not present
  static Future<void> updateUserStatus(bool isOnline, String email,isReady) async {
    try {
      if (email != '') {
        var userDoc = firestore.collection('users').doc(email);
        var docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set({
            'email': email,
            'isOnline': isOnline,
            'isReady': isReady,
          });
        } else {
          await userDoc.update({
            'isOnline': isOnline,
            'isReady': isReady,
          });
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  static Future<void> createLobby(String lobbyName, int totalPlayers, String gameMode, String gameMap, String lobbyType, String creatorEmail) async {
    try {
      var lobbyDocRef = firestore.collection('lobby').doc(lobbyName);
      await lobbyDocRef.set({
        'name': lobbyName,
        'players': [
          {
            'email': creatorEmail,
            'playerType': 'host',
            'readyStatus': false
          }
        ],
        'maxPlayers': totalPlayers,
        'currentPlayers': 1,
        'createdAt': DateTime.now(),
        'timeStamp': FieldValue.serverTimestamp(), // Use server timestamp
        'gameMode': 'Team Deathmatch',
        'gameMap': 'Map Name',
        'gameSettings': {
          'timeLimit': 10,
          'scoreLimit': 100,
          'respawnEnabled': true,
        },
        'region': 'US East',
        'privacy': 'public',
        'voiceChat': true,
        'spectatorEnabled': true,
        'lobbyStatus': 'waiting',
        'leaderEmail' : creatorEmail
      });
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  static Stream<List<Lobby>> streamLobbies() {
    return firestore.collection('lobby')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => 
      Lobby.fromSnapshot(doc)).toList()
    );
  }

  static Stream<List<UserFireBase>> listPlayersInLobby(String lobbyName) {
    return firestore.collection('lobby').doc(lobbyName)
      .snapshots()
      .map((snapshot) {
        List<UserFireBase> players = [];
        if (snapshot.exists) {
          dynamic playerData = snapshot.data()?['players'];
          if (playerData is List) {
            players = playerData.map((player) => UserFireBase.fromMap(player)).toList();
          }
        }
        return players;
      });
  }

  static Future<void> updateUserInLobby(bool isOnline, String email, bool isReady, String lobbyName) async {
    try {
      var userDoc = firestore.collection('users').doc(email);
      var docSnapshot = await userDoc.get();
      if (docSnapshot.exists) {
        if (isOnline && lobbyName.isNotEmpty) {
          var lobbyDocRef = firestore.collection('lobby').doc(lobbyName);
          var lobbySnapshot = await lobbyDocRef.get();
          if (lobbySnapshot.exists) {
            var playersList = lobbySnapshot.data()?['players'] ?? [];
            log(playersList.toString());
            if(playersList is List){
              // Check if the user is already in the lobby
              var existingPlayer = playersList.firstWhere((player) => player['email'] == email, orElse: () => null);
              if (existingPlayer == null) {
                // Add player to lobby only if not already in the lobby
                playersList.add({
                  'email': email,
                  'playerType': 'player',
                  'readyStatus': isReady,
                });
                await lobbyDocRef.update({
                  'players': playersList,
                });
              }
              else {
                log('existing player exist');
                // Find the index of the existing player in the playersList
                int existingPlayerIndex = playersList.indexWhere((player) => player['email'] == email);
                if (existingPlayerIndex != -1) {
                  // Update existing player's data at the found index
                  playersList[existingPlayerIndex]['readyStatus'] = isReady;
                  await lobbyDocRef.update({
                    'players': playersList,
                  });
                }
              }
            }
            else{
              log('PlayerList is not a List');
            }
          }
          else{
            log('No User Exist');
          }
          await userDoc.update({
            'isOnline': isOnline,
            'isReady': isReady,
          });
        } else {
          var lobbyDocRef = firestore.collection('lobby').doc(docSnapshot.data()?['lobbyName']);
          var lobbySnapshot = await lobbyDocRef.get();
          if (lobbySnapshot.exists) {
            var playersList = lobbySnapshot.data()?['players'] ?? [];
            playersList.removeWhere((player) => player['email'] == email);
            await lobbyDocRef.update({
              'players': playersList,
            });
          }
          await userDoc.update({
            'isOnline': isOnline,
            'isReady': isReady,
          });
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }
}
