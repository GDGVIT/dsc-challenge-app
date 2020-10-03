import 'dart:convert';
import 'dart:io';

import 'package:daily_mcq/src/data/helpers/constants.dart';
import 'package:daily_mcq/src/data/helpers/errors.dart';
import 'package:http/http.dart' as http;

import '../helpers/api_response.dart';
import '../models/leaderboard.dart';

class LeaderboardRepository {
  static Future<ApiResponse<Leaderboard>> getLeaderBoard() async {
    String url = BASE_URL + LEADERBOARD;

    try {
      final response = await http.get(url);

      print("leaderboard ${response.statusCode}");

      switch (response.statusCode) {
        case 200:
          return ApiResponse.completed(
            Leaderboard.fromMap(
              jsonDecode(
                utf8.decode(response.bodyBytes),
              ),
            ),
          );
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
