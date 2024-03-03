import 'dart:async';
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
            'isOnline': isOnline,
            'email': email,
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

  static Future<void> createLobby(String lobbyName, int totalPlayers, String creatorEmail) async {
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
}
