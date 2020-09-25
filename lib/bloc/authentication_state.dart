part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  final AuthenticationStatus authenticationStatus;
  final UserModel userModel;

  const AuthenticationState._(
      {this.authenticationStatus = AuthenticationStatus.unknown,
      this.userModel = UserModel.empty});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.unauthenticated()
      : this._(authenticationStatus: AuthenticationStatus.unauthenticated);

  const AuthenticationState.authenticated(UserModel userModel)
      : this._(authenticationStatus: AuthenticationStatus.authenticated);

  @override
  // TODO: implement props
  List<Object> get props => [authenticationStatus, userModel];
}
