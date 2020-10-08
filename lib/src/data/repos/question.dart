import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
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
  static Future<ApiResponse<Question>> getQuestion(QuestionType questionType) async {
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
          return ApiResponse.completed(
            Question(
              question: QuestionClass(
                displayDate: DateTime.now(),
                questionType: questionType.index,
                questionBody: NO_CONTENT,
              ),
            ),
          );
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
      return ApiResponse.error(EXCEPTION);
    }
  }

  static Future<ApiResponse<bool>> submitAnswer({
    @required QuestionType questionType,
    @required int id,
    @required String answer,
    String description,
  }) async {
    String url = BASE_URL;
    switch (questionType) {
      case QuestionType.Daily:
        url += DAILY_QUESTION;
        break;
      case QuestionType.Weekly:
        url += WEEKLY_QUESTION;
        break;
    }
    Map<String, dynamic> body;

    if (description.isEmpty) {
      body = {
        "question_id": id,
        "answer_body": answer,
      };
    } else {
      body = {
        "question_id": id,
        "answer_body": answer,
        "description": description,
      };
    }

    Box box = await Hive.openBox("userBox");
    String token = box.get("user_token");
    try {
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.authorizationHeader: "Token $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(body),
      );

      print(
        "post question ${questionType.index} returned ${response.statusCode}",
      );

      switch (response.statusCode) {
        case 200:
          return ApiResponse.completed(true);
          break;
        case 400:
          print(response.body);
          return ApiResponse.error("Already answered");
          break;
        default:
          return ApiResponse.error(EXCEPTION + " Code: ${response.statusCode}");
          break;
      }
    } on SocketException {
      return ApiResponse.error(NO_INTERNET_CONNECTION);
    } catch (e) {
      return ApiResponse.error(EXCEPTION);
    }
  }
}
