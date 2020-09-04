import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../data/helpers/api_response.dart';
import '../../../data/helpers/errors.dart';
import '../../../data/models/user.dart';
import '../../../data/repos/user.dart';

part 'googlesignin_event.dart';
part 'googlesignin_state.dart';

class GooglesigninBloc extends Bloc<GooglesigninEvent, GooglesigninState> {
  GooglesigninBloc() : super(Initial());

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
    } else if (event is UpdateInstaHandle) {
      yield* _mapUpdateInstaHandleToState(event.handle);
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
    yield LoginLoading();
    final response = await _userRepository.login();
    switch (response.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        final hiveInstance = await Hive.openBox('userBox');
        hiveInstance.put("user_token", response.data.token);
        hiveInstance.put('user', response.data.user.toJson());
        hiveInstance.put("logged_in", true);

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

  Stream<GooglesigninState> _mapUpdateInstaHandleToState(String handle) async* {
    yield LoginLoading();
    final response = await _userRepository.updateInstaHandle(handle);
    switch (response.status) {
      case Status.LOADING:
        break;
      case Status.COMPLETED:
        yield InstaHandleUpdateSuccess();
        break;
      case Status.ERROR:
        yield InstaHandleUpdateFailed(message: response.message);
        break;
    }
  }
}
