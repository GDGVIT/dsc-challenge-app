import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../services/constants.dart';
import '../../services/helpers/api_response.dart';
import '../../services/helpers/errors.dart';
import '../models/user.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on SocketException {
      print("no internet");
    } catch (e) {
      print(e.toString());
    }
    return _firebaseAuth.currentUser();
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<IdTokenResult> getUserToken() async {
    return (await _firebaseAuth.currentUser()).getIdToken(refresh: false);
  }

  Future<ApiResponse<User>> login() async {
    try {
      final firebaseUser = await signInWithGoogle();
      // if (firebaseUser == null) {
      //   return ApiResponse.error("Uunable to login at the moment");
      // }
      final token = await getUserToken();
      print('token : ${token.token}');

      final response = await http.post(
        BASE_URL + LOGIN,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode({
          "id_token": token.token,
        }),
      );

      print("login response ${response.statusCode}");

      switch (response.statusCode) {
        case 200:
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
}
