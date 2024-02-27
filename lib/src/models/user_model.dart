import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class UserFb {
  final String email;
  final bool isOnline;
  final bool isReady;

  UserFb({required this.email, required this.isOnline,required this.isReady});

  factory UserFb.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserFb(
      email: data['email'] ?? '',
      isOnline: data['isOnline'] ?? false,
      isReady: data['isReady'] ?? false,
    );
  }
}

class UserFireBase {
  final String email;
  final bool isOnline;
  final bool isReady;

  UserFireBase({required this.email, required this.isOnline, required this.isReady});

  factory UserFireBase.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserFireBase(
      email: data['email'] ?? '', 
      isOnline: data['isOnline'] ?? false,
      isReady: data['isReady'] ?? false,
    );
  }
}

