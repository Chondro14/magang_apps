import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth firebaseAuth;
  UserRepository({FirebaseAuth firebaseAuth})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  Future<void> sendOtp(
      String phoneNumber,
      Duration timeout,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneCodeSent phoneCodeSent,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout) async {
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);

  }
  Future<void> verifyLogin(
    String verificationId,
    String smsCode,
  ) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    return firebaseAuth.signInWithCredential(authCredential);
  }

  Future<User> getUser() async {
    var user = await firebaseAuth.currentUser;
    return user;
  }
}
