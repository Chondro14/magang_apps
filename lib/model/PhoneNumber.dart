import 'package:formz/formz.dart';

enum PhoneNumberError { invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberError> {
  const PhoneNumber.pure() : super.pure('');

  PhoneNumber.dirty([String value]) : super.dirty(value);
  static final RegExp phone = RegExp(
      // ignore: valid_regexps
      '\+?([ -]?\d+)+|\(\d+\)([ -]\d+)');

  @override
  validator(String value) {
    return phone.hasMatch(value) ? null : PhoneNumberError.invalid;
  }
}
