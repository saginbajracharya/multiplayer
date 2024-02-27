import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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

  // Update user's online status and add user if not present
  static Future<void> updateUserStatus(bool isOnline, String email) async {
    try {
      if (email != '') {
        var userDoc = firestore.collection('users').doc(email);
        var docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set({
            'isOnline': isOnline,
            'email': email,
          });
        } else {
          await userDoc.update({
            'isOnline': isOnline,
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
