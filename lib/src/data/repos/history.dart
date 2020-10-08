import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../helpers/api_response.dart';
import '../helpers/constants.dart';
import '../helpers/errors.dart';
import '../models/history.dart';
import 'question.dart';

class QuestionHistoryRepo {
  static Future<ApiResponse<QuestionHistory>> getHistory(
    QuestionType questionType,
  ) async {
    final url = BASE_URL + HISTORY;
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
      print(
        "get history with type as ${questionType.index} returned ${response.statusCode}",
      );
      switch (response.statusCode) {
        case 200:
          QuestionHistory _history = QuestionHistory.fromMap(
              jsonDecode(utf8.decode(response.bodyBytes)));
          _history.history.retainWhere(
            (element) => element.questionType == questionType.index,
          );
          return ApiResponse.completed(_history);
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
