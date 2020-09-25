import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';
import 'package:magang_apps/model/PhoneNumber.dart';
import 'package:magang_apps/repository/AuthenticationRepository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  String phoneNumber;
  Duration timeOut = Duration(seconds: 60);
  String verId = '';
  String smsCode = '';
  FirebaseAuth auth;
  final AuthenticationRepository authenticationRepository;

  LoginCubit(this.authenticationRepository)
      : assert(authenticationRepository != null),
        super(LoginState());

  Future<void> loginWithCodePhone(String smsCode, String verId) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      User user = FirebaseAuth.instance.currentUser;

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> smsCodeSent() async {
    final PhoneCodeAutoRetrievalTimeout timeout = (String verId) {
      this.verId = verId;
    };
    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeResent]) async {
      this.verId = verId;
      Random value = Random();

      int a = value.nextInt(9);
      int b = value.nextInt(9);
      int c = value.nextInt(9);
      int d = value.nextInt(9);
      int e = value.nextInt(9);
      try {
        smsCode = a.toString() +
            b.toString() +
            c.toString() +
            d.toString() +
            e.toString();
        loginWithCodePhone(smsCode, verId).then((value) async {
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
                  verificationId: verId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await auth.signInWithCredential(phoneAuthCredential);
        });

        // ...
      } on PlatformException catch (e) {
        if (e.message.contains(
            'The sms verification code used to create the phone auth credential is invalid')) {
          print(
              'The sms verification code used to create the phone auth credential is invalid');
          // ...
        } else if (e.message.contains('The sms code has expired')) {
          print('The sms code has expired');
          // ...
        }
      }

      // Sign the user in (or link) with the credential
    };
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
      auth.setLanguageCode('id');
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      if (exception.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
    };

    if (!state.status.isValidated) ;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await authenticationRepository.sendSmsCodeOTP(phoneNumber, timeOut,
          verificationFailed, smsCodeSent, verificationCompleted, timeout);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    } on NoSuchMethodError {
      emit(state.copyWith(status: (FormzStatus.pure)));
    }
  }

  // ignore: non_constant_identifier_names
  void PhoneNumberChanged(String value) {
    final phoneNumber = PhoneNumber.dirty(value);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([phoneNumber]),
    ));
  }
}