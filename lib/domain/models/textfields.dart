
import 'package:formz/formz.dart';

enum TextFieldsValidationError { invalid,}

class TextFields extends FormzInput<String, TextFieldsValidationError> {
  const TextFields.pure([String value = '']) : super.pure(value);
  const TextFields.dirty([String value = '']) : super.dirty(value);

  @override
  TextFieldsValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : TextFieldsValidationError.invalid;
  }
}
