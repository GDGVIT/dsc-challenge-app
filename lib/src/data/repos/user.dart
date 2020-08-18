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
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '1010322422291-0baag24oc9bq29c70ff7a9fq1e6kql2d.apps.googleusercontent.com',
    signInOption: SignInOption.standard,
  );

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
    return Future.wait([
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final signedInStatus = await _googleSignIn.isSignedIn();
    return signedInStatus;
  }

  // Future<IdTokenResult> getUserToken() async {
  //   return (await _firebaseAuth.currentUser()).getIdToken(refresh: false);
  // }

  Future<ApiResponse<User>> login() async {
    try {
      final googleUser = await signInWithGoogle();
      print(googleUser.displayName);
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
