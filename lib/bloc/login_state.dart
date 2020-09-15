import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable{}
class InitialLoginState extends LoginState{
  @override
  List<Object> get props=>[];
}
class OtpSentState extends LoginState{
  List<Object> get props=>[];
}
class LoadingState extends LoginState{
  List<Object> get props=>[];
}
class OtpVerifiedState extends LoginState{
  List<Object> get props=>[];
}
class LoginCompleteState extends LoginState{
  FirebaseUser firebaseUser;
  LoginCompleteState(this.firebaseUser);
  FirebaseUser getUser(){return firebaseUser;}
  List<Object> get props =>[firebaseUser];
}
class ExceptionState extends LoginState{
  String message;
  ExceptionState({this.message});
  List<Object> get props=>[message];
}
class OtpExceptionState extends LoginState{
  String message;
  OtpExceptionState({this.message});
  List<Object> get props=> [message];
}