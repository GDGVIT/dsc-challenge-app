// To parse this JSON data, do
//
//     final questionHistory = questionHistoryFromMap(jsonString);

import 'dart:convert';

QuestionHistory questionHistoryFromMap(String str) =>
    QuestionHistory.fromMap(json.decode(str));

String questionHistoryToMap(QuestionHistory data) => json.encode(data.toMap());

class QuestionHistory {
  QuestionHistory({
    this.message,
    this.history,
  });

  String message;
  List<History> history;

  factory QuestionHistory.fromMap(Map<String, dynamic> json) => QuestionHistory(
        message: json["message"],
        history:
            List<History>.from(json["history"].map((x) => History.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "history": List<dynamic>.from(history.map((x) => x.toMap())),
      };
}

class History {
  History({
    this.question,
    this.displayDate,
    this.yourAnswer,
    this.correctAnswer,
    this.marks,
    this.questionType,
  });

  String question;
  DateTime displayDate;
  String yourAnswer;
  String correctAnswer;
  double marks;
  int questionType;

  factory History.fromMap(Map<String, dynamic> json) => History(
        question: json["question"],
        displayDate: DateTime.parse(json["display_date"]),
        yourAnswer: json["your_answer"],
        correctAnswer: json["correct_answer"],
        marks: json["marks"],
        questionType: json["question_type"],
      );

  Map<String, dynamic> toMap() => {
        "question": question,
        "display_date": displayDate.toIso8601String(),
        "your_answer": yourAnswer,
        "correct_answer": correctAnswer,
        "marks": marks,
        "question_type": questionType,
      };
}
