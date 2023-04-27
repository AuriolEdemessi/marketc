import 'package:formz/formz.dart';

enum PasswordValidationError { empty, valid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([String value = '']) : super.pure(value);
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : PasswordValidationError.empty;
  }
}

/*extension Explanation on PasswordValidationError {
  String? get name {
    switch(this) {
      case PasswordValidationError.empty:
        return "Invalid condition";
      default:
        return null;
    }
  }
}*/
