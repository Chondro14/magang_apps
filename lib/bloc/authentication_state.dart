import 'package:meta/meta.dart';
@immutable
abstract class AuthenticationState{}
class InitialAuthenticationState extends AuthenticationState{}
class UninitializedAuthenticationState extends AuthenticationState{}
class Authenticated extends AuthenticationState{}
class UnAuthenticated extends AuthenticationState{}
class Loading extends AuthenticationState{}
