part of 'history_cubit.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final QuestionHistory history;

  HistoryLoaded({@required this.history});
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError({@required this.message});
}
