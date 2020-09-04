// To parse this JSON data, do
//
//     final question = questionFromMap(jsonString);

import 'dart:convert';

Question questionFromMap(String str) => Question.fromMap(json.decode(str));

String questionToMap(Question data) => json.encode(data.toMap());

class Question {
  Question({
    this.message,
    this.question,
  });

  String message;
  QuestionClass question;

  factory Question.fromMap(Map<String, dynamic> json) => Question(
        message: json["message"],
        question: QuestionClass.fromMap(json["Question"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "Question": question.toMap(),
      };
}

class QuestionClass {
  QuestionClass({
    this.id,
    this.questionBody,
    this.displayDate,
    this.questionType,
    this.isExactMatch,
    this.creationDateTime,
  });

  int id;
  String questionBody;
  DateTime displayDate;
  int questionType;
  bool isExactMatch;
  DateTime creationDateTime;

  factory QuestionClass.fromMap(Map<String, dynamic> json) => QuestionClass(
        id: json["id"],
        questionBody: json["question_body"],
        displayDate: DateTime.parse(json["display_date"]),
        questionType: json["question_type"],
        isExactMatch: json["is_exact_match"],
        creationDateTime: DateTime.parse(json["creation_date_time"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "question_body": questionBody,
        "display_date": displayDate.toIso8601String(),
        "question_type": questionType,
        "is_exact_match": isExactMatch,
        "creation_date_time": creationDateTime.toIso8601String(),
      };
}
