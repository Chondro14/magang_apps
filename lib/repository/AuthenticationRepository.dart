import 'package:firebase_auth/firebase_auth.dart';
import 'package:magang_apps/model/user.dart';

class SignUpFailure implements Exception {}

class LoginWithPhoneNumberFailure implements Exception {}

class LogoutWithPhoneNumber implements Exception {}

class SendOTPFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  FirebaseAuth _firebaseAuth;

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
    });
  }

  Future<void> sendSmsCodeOTP(
      String phoneNumber,
      Duration timeout,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneCodeSent phoneCodeSent,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout) async {
    try {
      _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: phoneVerificationCompleted,
          verificationFailed: phoneVerificationFailed,
          codeSent: phoneCodeSent,
          codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
    } on Exception {
      throw SendOTPFailure();
    }
  }

  Future<void> loginWithPhoneNumber(
      String verificationId, String smsCode) async {
    try {
      AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      return _firebaseAuth.signInWithCredential(authCredential);
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
