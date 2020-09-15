import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginEvent extends Equatable{
   @override
  List<Object> get props=>[];
}
class SendOtpEvent extends LoginEvent{
  String phoneNo;
  SendOtpEvent({this.phoneNo});
}
class AppStartEvent extends LoginEvent{}
// ignore: must_be_immutable
class VerifyOtpEvent extends LoginEvent{
  String otp;
  VerifyOtpEvent({this.otp});
}
class LogoutEvent extends LoginEvent{}
class OtpSendEvent extends LoginEvent{}
class LoginCompleteEvent extends LoginEvent{
  final FirebaseUser firebaseUser;
  LoginCompleteEvent({this.firebaseUser});
}
class LoginExceptionEvent extends LoginEvent{
  String message;
  LoginExceptionEvent({this.message});
}

