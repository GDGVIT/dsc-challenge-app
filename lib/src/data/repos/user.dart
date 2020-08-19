import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../services/constants.dart';
import '../../services/helpers/api_response.dart';
import '../../services/helpers/errors.dart';
import '../models/user.dart';

class UserRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      print(googleUser.displayName);
      return googleUser;
    } catch (e) {
      print("Exception on google sign in ${e.toString()}");
    }
  }

  Future<void> signOut() async {
    Hive.box("userBox").put("logged_in", false);
    return Future.wait([
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final signedInStatus = await _googleSignIn.isSignedIn();
    return signedInStatus;
  }

  Future<ApiResponse<User>> login() async {
    try {
      final googleUser = await signInWithGoogle();
      final hiveInstance = await Hive.openBox('userBox');

      hiveInstance.put('photo_url', googleUser.photoUrl);
      hiveInstance.put('display_name', googleUser.displayName);

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final response = await http.post(
        BASE_URL + LOGIN,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode({
          "id_token": googleAuth.idToken,
        }),
      );

      print("login response ${response.statusCode}");

      switch (response.statusCode) {
        case 200:
          print("${jsonDecode(response.body)}");
          return ApiResponse.completed(
            userFromJson(utf8.decode(response.bodyBytes)),
          );
          break;
        case 400:
        case 401:
          return ApiResponse.error(UNABLE_TO_LOGIN);
          break;
        default:
          print("${jsonDecode(response.body)}");
          return ApiResponse.error("Code ${response.statusCode}, $EXCEPTION");
          break;
      }
    } on SocketException {
      return ApiResponse.error(NO_INTERNET_CONNECTION);
    } catch (e) {
      print("login exception : ${e.toString()}");
      return ApiResponse.error(EXCEPTION + "${e.toString()}");
    }
  }

  Future<ApiResponse<bool>> updateInstaHandle(String handle) async {
    if (handle.contains("@")) {
      handle = handle.replaceAll("@", "").trim();
    }

    Box box = await Hive.openBox("userBox");
    UserClass user = UserClass.fromJson(box.get("user"));
    String token = box.get("user_token");

    const url = BASE_URL + INSTA_HANDLE_UPDATE;

    try {
      final response = await http.patch(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Token $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode({"insta_handle": handle}),
      );

      print("update insta handle ${response.statusCode}");

      switch (response.statusCode) {
        case 200:
          user.instaHandle = handle;
          box.put("user", user.toJson());
          return ApiResponse.completed(true);
          break;
        case 401:
          return ApiResponse.error(UNABLE_TO_LOGIN);
          break;
        default:
          print("${jsonDecode(response.body)}");
          return ApiResponse.error("Code ${response.statusCode}, $EXCEPTION");
          break;
      }
    } on SocketException {
      return ApiResponse.error(NO_INTERNET_CONNECTION);
    } catch (e) {
      print("update_insta exception : ${e.toString()}");
      return ApiResponse.error(EXCEPTION + "${e.toString()}");
    }
  }
}
