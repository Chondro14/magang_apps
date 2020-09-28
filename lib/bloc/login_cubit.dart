import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:magang_apps/model/PhoneNumber.dart';
import 'package:magang_apps/repository/AuthenticationRepository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  Duration timeOut = Duration(seconds: 60);
  String verId;

  FirebaseAuth auth = FirebaseAuth.instance;
  final AuthenticationRepository authenticationRepository;

  LoginCubit(this.authenticationRepository)
      : assert(authenticationRepository != null),
        super(LoginState());

  Future<void> loginWithCodePhone(String smsCode, String verId) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      loginWithCodePhone(smsCode, verId);
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> smsCodeSent(
      String phoneNumber, String smsCode, String verId) async {
    try {
      await authenticationRepository.sendSmsCodeOTP(
          smsCode, verId, phoneNumber);
    } on FirebaseAuthException catch (e) {
      print(e);
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