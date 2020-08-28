// To parse this JSON data, do
//
//     final history = historyFromMap(jsonString);

import 'dart:convert';

History historyFromMap(String str) => History.fromMap(json.decode(str));

String historyToMap(History data) => json.encode(data.toMap());

class History {
  History({
    this.message,
    this.history,
  });

  String message;
  List<HistoryElement> history;

  factory History.fromMap(Map<String, dynamic> json) => History(
        message: json["message"],
        history: List<HistoryElement>.from(
            json["history"].map((x) => HistoryElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "history": List<dynamic>.from(history.map((x) => x.toMap())),
      };
}

class HistoryElement {
  HistoryElement({
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
  int marks;
  int questionType;

  factory HistoryElement.fromMap(Map<String, dynamic> json) => HistoryElement(
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
