import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../helpers/api_response.dart';
import '../helpers/constants.dart';
import '../helpers/errors.dart';
import '../models/question.dart';

enum QuestionType {
  Daily,
  Weekly,
}

class QuestionRepository {
  static Future<ApiResponse<Question>> getQuestion(
      QuestionType questionType) async {
    print("getting question with type as ${questionType.index}");
    String url = BASE_URL;
    switch (questionType) {
      case QuestionType.Daily:
        url += DAILY_QUESTION;
        break;
      case QuestionType.Weekly:
        url += WEEKLY_QUESTION;
        break;
    }
    Box box = await Hive.openBox("userBox");
    String token = box.get("user_token");
    try {
      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Token $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      print("get question ${response.statusCode}");
      switch (response.statusCode) {
        case 200:
          return ApiResponse.completed(
            Question.fromMap(
              jsonDecode(
                utf8.decode(response.bodyBytes),
              ),
            ),
          );
          break;
        case 204:
          return ApiResponse.error(NO_CONTENT);
          break;
        case 400:
          return ApiResponse.error(INACTIVE_LOGOUT);
          break;
        default:
          return ApiResponse.error(EXCEPTION + " Code: ${response.statusCode}");
          break;
      }
    } on SocketException {
      return ApiResponse.error(NO_INTERNET_CONNECTION);
    } catch (e) {
      return ApiResponse.error(EXCEPTION + e.toString());
    }
  }
}
