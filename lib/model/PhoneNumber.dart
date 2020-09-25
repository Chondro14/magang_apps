import 'package:formz/formz.dart';

enum PhoneNumberError { invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberError> {
  const PhoneNumber.pure() : super.pure('');

  PhoneNumber.dirty([String value]) : super.dirty(value);
  static final RegExp phone = RegExp(
    r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$',
  );

  @override
  validator(String value) {
    return phone.hasMatch(value) ? null : PhoneNumberError.invalid;
  }
}
