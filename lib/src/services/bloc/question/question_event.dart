part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class GetDailyQuestion extends QuestionEvent {}

class GetWeeklyQuestion extends QuestionEvent {}

class PostQuestion extends QuestionEvent {
  final QuestionType questionType;
  final int id;
  final String answer;
  final String description;

  PostQuestion({
    @required this.questionType,
    @required this.id,
    @required this.answer,
    this.description,
  });
}
