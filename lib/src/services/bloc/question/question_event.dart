part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class GetDailyQuestion extends QuestionEvent {}

class PostDailyQuestion extends QuestionEvent {}

class GetWeeklyQuestion extends QuestionEvent {}

class PostWeeklyQuestion extends QuestionEvent {}
