import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_apps/model/user.dart';
import 'package:magang_apps/repository/AuthenticationRepository.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _userRepository;
  StreamSubscription<UserModel> user;

  AuthenticationBloc({
    @required AuthenticationRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    user = _userRepository.user
        .listen((user) => add(AuthenticationUserChanged(user)));
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationUserChanged) {
      yield _mapAuthenticationUserChangedState(event);
    } else if (event is AuthenticationLogoutRequest) {
      unawaited(_userRepository.logOutUserAccount());
    }
  }

  Future<void> close() {
    user?.cancel();
    return super.close();
  }

  AuthenticationState _mapAuthenticationUserChangedState(
      AuthenticationUserChanged userChanged) {
    return userChanged.userModel != UserModel.empty
        ? AuthenticationState.authenticated(userChanged.userModel)
        : const AuthenticationState.unauthenticated();
  }
}
