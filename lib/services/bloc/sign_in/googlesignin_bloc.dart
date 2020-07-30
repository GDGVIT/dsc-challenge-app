import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user.dart';
import '../../../data/repos/user.dart';
import '../../helpers/api_response.dart';
import '../../helpers/errors.dart';

part 'googlesignin_event.dart';
part 'googlesignin_state.dart';

class GooglesigninBloc extends Bloc<GooglesigninEvent, GooglesigninState> {
  GooglesigninBloc() : super(Initial());

  //TODO: add firebase auth and google sign in
  final UserRepository _userRepository = UserRepository();

  @override
  Stream<GooglesigninState> mapEventToState(
    GooglesigninEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is Login) {
      yield* _mapLoggedInToState();
    } else if (event is Logout) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<GooglesigninState> _mapAppStartedToState() async* {
    try {
      final signedIn = await _userRepository.isSignedIn();
      if (signedIn) {
        final hiveInstance = await Hive.openBox('userBox');

        yield Authenticated(user: User.fromJson(hiveInstance.get('user')));
      } else {
        yield Unauthenticated(message: INACTIVE_LOGOUT);
      }
    } catch (_) {
      yield Unauthenticated(message: INACTIVE_LOGOUT);
    }
  }

  Stream<GooglesigninState> _mapLoggedInToState() async* {
    final response = await _userRepository.login();
    switch (response.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        final hiveInstance = await Hive.openBox('userBox');

        hiveInstance.put('user', response.data.toJson());

        yield Authenticated(user: response.data);
        break;
      case Status.ERROR:
        yield Unauthenticated(message: response.message);
        break;
    }
  }

  Stream<GooglesigninState> _mapLoggedOutToState() async* {
    yield Unauthenticated(message: 'Logging Out');
    _userRepository.signOut();
  }
}