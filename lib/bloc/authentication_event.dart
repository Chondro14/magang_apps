part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final UserModel userModel;

  const AuthenticationUserChanged(this.userModel);

  @override
  // TODO: implement props
  List<Object> get props => [userModel];
}

class AuthenticationLogoutRequest extends AuthenticationEvent {
}
