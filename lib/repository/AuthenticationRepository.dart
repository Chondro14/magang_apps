import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:magang_apps/model/user.dart';

class SignUpFailure implements Exception {}

class LoginWithPhoneNumberFailure implements Exception {}

class LogoutWithPhoneNumber implements Exception {}

class SendOTPFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  FirebaseAuth _firebaseAuth;
  String verId;

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((User firebaseUser) {
      if (firebaseUser == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
      return firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
    });
  }

  Future<void> sendSmsCodeOTP(
      String smsCode, String verId, String phoneNumber) async {
    final PhoneCodeAutoRetrievalTimeout timeout = (String verId) {
      this.verId = verId;
    };
    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeResent]) async {
      this.verId = verId;
      try {
        loginWithPhoneNumber(smsCode, verId).then((value) async {
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
                  verificationId: verId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
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
      await _firebaseAuth.signInWithCredential(credential);
      _firebaseAuth.setLanguageCode('id');
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      if (exception.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
    };

    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: smsCodeSent,
          codeAutoRetrievalTimeout: timeout);
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
  }

  Future<void> loginWithPhoneNumber(
      String verificationId, String smsCode) async {
    try {
      AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await _firebaseAuth.signInWithCredential(authCredential);
    } on Exception {
      throw LoginWithPhoneNumberFailure();
    }
  }

  Future<void> logOutUserAccount() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } on Exception {
      throw LogoutWithPhoneNumber();
    }
  }
}

extension on User {
  UserModel get toUser {
    return UserModel(
        id: uid,
        userPhoneNumber: phoneNumber,
        userEmail: email,
        userName: displayName,
        userPassword: '',
        userPhotoProfile: photoURL);
  }
}
