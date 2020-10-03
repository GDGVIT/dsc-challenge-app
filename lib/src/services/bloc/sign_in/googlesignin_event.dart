part of 'googlesignin_bloc.dart';

abstract class GooglesigninEvent extends Equatable {
  const GooglesigninEvent();
}

class AppStarted extends GooglesigninEvent {
  @override
  List<Object> get props => [];
}

class Login extends GooglesigninEvent {
  @override
  List<Object> get props => [];
}

class Logout extends GooglesigninEvent {
  @override
  List<Object> get props => [];
}

class UpdateInstaHandle extends GooglesigninEvent {
  final String handle;

  UpdateInstaHandle({@required this.handle});

  @override
  List<Object> get props => [];
}
