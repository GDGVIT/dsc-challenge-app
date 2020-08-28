import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../data/helpers/api_response.dart';
import '../../../data/models/history.dart';
import '../../../data/repos/history.dart';
import '../../../data/repos/question.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  Future<void> getHistory(QuestionType questionType) async {
    emit(HistoryLoading());
    final response = await QuestionHistoryRepo.getHistory(questionType);

    switch (response.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        emit(HistoryLoaded(history: response.data));
        break;
      case Status.ERROR:
        emit(HistoryError(message: response.message));
        break;
    }
  }
}
