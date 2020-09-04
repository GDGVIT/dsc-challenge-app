part of 'googlesignin_bloc.dart';

abstract class GooglesigninState extends Equatable {
  const GooglesigninState();
}

class Initial extends GooglesigninState {
  @override
  List<Object> get props => [];
}

class Authenticated extends GooglesigninState {
  final User user;

  Authenticated({@required this.user});

  @override
  List<Object> get props => [];
}

class Unauthenticated extends GooglesigninState {
  final String message;

  Unauthenticated({@required this.message});
  @override
  List<Object> get props => [];
}

class LoginLoading extends GooglesigninState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class InstaHandleUpdateSuccess extends GooglesigninState {
  @override
  List<Object> get props => [];
}

class InstaHandleUpdateFailed extends GooglesigninState {
  final String message;

  InstaHandleUpdateFailed({@required this.message});
  @override
  List<Object> get props => [];
}
