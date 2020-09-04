part of 'leaderboard_cubit.dart';

abstract class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object> get props => [];
}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardSuccess extends LeaderboardState {
  final Leaderboard leaderboard;

  LeaderboardSuccess({@required this.leaderboard});
}

class LeaderboardError extends LeaderboardState {
  final String message;

  LeaderboardError({@required this.message});
}
