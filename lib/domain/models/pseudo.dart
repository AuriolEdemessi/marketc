
import 'package:formz/formz.dart';

enum PseudoValidationError { invalid,}

class Pseudo extends FormzInput<String, PseudoValidationError> {
  const Pseudo.pure([String value = '']) : super.pure(value);
  const Pseudo.dirty([String value = '']) : super.dirty(value);

  @override
  PseudoValidationError? validator(String value) {
    return value.length<5 ? PseudoValidationError.invalid:null;
  }
}
