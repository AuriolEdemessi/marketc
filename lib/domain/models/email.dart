
import 'package:formz/formz.dart';

enum EmailValidationError { invalid,}

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure([String value = '']) : super.pure(value);
  const Email.dirty([String value = '']) : super.dirty(value);

    //static final RegExp _emailRegExp = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',);
    static final RegExp _emailRegExp = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");

  @override
  EmailValidationError? validator(String? value) {
    return  _emailRegExp.hasMatch(value ?? '')
        ?  null
        : EmailValidationError.invalid;
  }
}
