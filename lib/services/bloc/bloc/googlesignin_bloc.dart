import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'googlesignin_event.dart';
part 'googlesignin_state.dart';

class GooglesigninBloc extends Bloc<GooglesigninEvent, GooglesigninState> {
  GooglesigninBloc() : super(GooglesigninInitial());

  @override
  Stream<GooglesigninState> mapEventToState(
    GooglesigninEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
