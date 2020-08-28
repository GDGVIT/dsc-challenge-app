part of 'question_bloc.dart';

abstract class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

class QuestionInitial extends QuestionState {}

class QuestionLoading extends QuestionState {}

class GetDailyQuestionSucess extends QuestionState {
  final Question question;

  GetDailyQuestionSucess({@required this.question});
}

class GetDailyQuestionError extends QuestionState {
  final String message;

  GetDailyQuestionError({@required this.message});
}

class GetWeeklyQuestionSucess extends QuestionState {
  final Question question;

  GetWeeklyQuestionSucess({@required this.question});
}

class GetWeeklyQuestionError extends QuestionState {
  final String message;

  GetWeeklyQuestionError({@required this.message});
}
