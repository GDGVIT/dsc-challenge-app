// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.message,
    this.user,
    this.token,
  });

  String message;
  UserClass user;
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        message: json["message"],
        user: UserClass.fromJson(json["User"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "User": user.toJson(),
        "token": token,
      };
}

class UserClass {
  UserClass({
    this.username,
    this.email,
    this.instaHandle,
    this.platform,
  });

  String username;
  String email;
  String instaHandle;
  int platform;

  factory UserClass.fromJson(Map<dynamic, dynamic> json) => UserClass(
        username: json["username"],
        email: json["email"],
        instaHandle: json["insta_handle"],
        platform: json["platform"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "insta_handle": instaHandle,
        "platform": platform,
      };
}
