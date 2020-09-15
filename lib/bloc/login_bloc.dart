import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:magang_apps/bloc/bloc.dart';
import 'package:magang_apps/repository/repository.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  StreamSubscription subscription;
  FirebaseAuth auth=FirebaseAuth.instance;
  String smsCode;

  User user;
  String verId = '';
  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(null);
  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();
      subscription = sendOtp('+62' + event.phoneNo).listen((event) {
        add(event);
      });
    } else if (event is OtpSendEvent) {
      yield OtpSentState();
    } else if (event is LoginCompleteEvent) {
      yield LoginCompleteState(event.firebaseUser);
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: event.message);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        await _userRepository.verifyLogin(verId, event.otp);
        user=FirebaseAuth.instance.currentUser;
        if(user!=null){
          yield LoginCompleteState(user);
        }
        else{
          yield ExceptionState(message: 'Invalid OTP');
        }
      } catch (e) {
        yield OtpExceptionState(message: e.toString());
      }
    }
  }

  Stream<LoginEvent> sendOtp(String phoneNumber) async* {
    StreamController<LoginEvent> eventStream = StreamController();
    final PhoneVerificationCompleted = (PhoneAuthCredential authCredential) async{
      await auth.signInWithCredential(authCredential);
      auth.setLanguageCode('id');

      _userRepository.getUser();
      _userRepository.getUser().catchError((onError) {
        print(onError);
      }).then((user) {
        eventStream.add(LoginCompleteEvent(firebaseUser: user));
        eventStream.close();
      });
    };
    final PhoneVerificationFailed = (FirebaseAuthException exception) {
      print(exception.message);
      if(exception.code == 'invalid-phone-number'){
        eventStream.add(LoginExceptionEvent(message: exception.message.toString()));
        eventStream.close();
      }

    };
    final PhoneCodeSent = (String verId, [int forceResent]) async{
      this.verId = verId;
      Random value=Random();
      int a = value.nextInt(9);
      int b = value.nextInt(9);
      int c = value.nextInt(9);
      int d = value.nextInt(9);
      int e = value.nextInt(9);
      try{
        smsCode = a.toString() +
            b.toString() +
            c.toString() +
            d.toString() +
            e.toString();
        PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
        await auth.signInWithCredential(credential);


      }
      catch(e){}
      eventStream.close();
    };
    final PhoneCodeAutoRetrievalTimeout = (String verId) {
      this.verId = verId;
      eventStream.close();
    };
    try{
      await _userRepository.sendOtp(
          phoneNumber,
          Duration(minutes: 1),
          PhoneVerificationFailed,
          PhoneCodeSent,
          PhoneVerificationCompleted,
          PhoneCodeAutoRetrievalTimeout);
    }
    on PlatformException catch(e){
      if(e.message.contains('The sms verification code used to create the phone auth credential is invalid')){
        print(e.message);
      }
      else if(e.message.contains('The sms code has expired')){
        e.message.contains('The sms code has expired');
      }
    }


  }

  @override
  void onEvent(LoginEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print(error);
  }

  Future<void> close() async {
    print("bloc closed");
    super.close();
  }
}
