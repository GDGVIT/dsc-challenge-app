import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../data/helpers/api_response.dart';
import '../../../data/models/question.dart';
import '../../../data/repos/question.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc() : super(QuestionInitial());

  @override
  Stream<QuestionState> mapEventToState(
    QuestionEvent event,
  ) async* {
    if (event is GetDailyQuestion) {
      yield* _mapGetDailyQuestionToState();
    } else if (event is GetWeeklyQuestion) {
      yield* _mapGetWeelyQuestionToState();
    } else if (event is PostQuestion) {
      yield* _mapPostQuestionToState(
        questionType: event.questionType,
        id: event.id,
        answer: event.answer,
        description: event.description,
      );
    }
  }

  Stream<QuestionState> _mapPostQuestionToState({
    @required QuestionType questionType,
    @required int id,
    @required String answer,
    String description,
  }) async* {
    yield QuestionLoading();
    final response = await QuestionRepository.submitAnswer(
      questionType: questionType,
      id: id,
      answer: answer,
      description: description,
    );

    switch (response.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        yield PostQuestionSuccess();
        break;
      case Status.ERROR:
        yield PostQuestionFailure(message: response.message);
        break;
    }
  }

  Stream<QuestionState> _mapGetDailyQuestionToState() async* {
    yield QuestionLoading();
    final response = await QuestionRepository.getQuestion(QuestionType.Daily);
    switch (response.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        yield GetDailyQuestionSucess(question: response.data);
        break;
      case Status.ERROR:
        yield GetDailyQuestionError(message: response.message);
        break;
    }
  }

  Stream<QuestionState> _mapGetWeelyQuestionToState() async* {
    yield QuestionLoading();
    final response = await QuestionRepository.getQuestion(QuestionType.Weekly);
    switch (response.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        yield GetWeeklyQuestionSucess(question: response.data);
        break;
      case Status.ERROR:
        yield GetWeeklyQuestionError(message: response.message);
        break;
    }
  }
}
