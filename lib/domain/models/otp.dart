import 'package:formz/formz.dart';

enum OtpValidationError { empty, valid }

class OtpText extends FormzInput<String, OtpValidationError> {
  const OtpText.pure([String value = '']) : super.pure(value);
  const OtpText.dirty([String value = '']) : super.dirty(value);

  @override
  OtpValidationError? validator(String? value) {
    return value!.length==6
        ? null
        : OtpValidationError.valid;
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
