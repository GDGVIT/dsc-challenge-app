// To parse this JSON data, do
//
//     final leaderboard = leaderboardFromMap(jsonString);

import 'dart:convert';

Leaderboard leaderboardFromMap(String str) =>
    Leaderboard.fromMap(json.decode(str));

String leaderboardToMap(Leaderboard data) => json.encode(data.toMap());

class Leaderboard {
  Leaderboard({
    this.message,
    this.result,
  });

  String message;
  List<Result> result;

  factory Leaderboard.fromMap(Map<String, dynamic> json) => Leaderboard(
        message: json["message"],
        result: List<Result>.from(json["Result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "Result": List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.username,
    this.platform,
    this.instaHandle,
    this.profileImage,
    this.email,
    this.marks,
    this.key,
    this.position,
    this.topper,
  });

  String username;
  int platform;
  String instaHandle;
  String profileImage;
  String email;
  double marks;
  int key;
  int position;
  int topper;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        username: json["username"],
        platform: json["platform"],
        instaHandle: json["insta_handle"] == null ? null : json["insta_handle"],
        profileImage: json["profile_image"],
        email: json["email"],
        marks: json["marks"],
        key: json["key"],
        position: json["position"],
        topper: json["topper"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "platform": platform,
        "insta_handle": instaHandle == null ? null : instaHandle,
        "profile_image": profileImage,
        "email": email,
        "marks": marks,
        "key": key,
        "position": position,
        "topper": topper,
      };
}
