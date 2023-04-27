import 'package:marketscc/data/models/data_response.dart';
import 'package:marketscc/presentation/widgets/otp_text_field.dart';
import 'package:equatable/equatable.dart';

import '../../../../export.dart';

/*/// Base class for user states
abstract class OtpState extends Equatable {}

/// Initial state
class OtpInitial extends OtpState {
  @override
  List<Object?> get props => [];
}


class Submission extends OtpState {
  @override
  List<Object?> get props => [];
}

/// This state is emited when data is received.
class Received extends OtpState {
  /// Constructor.
  Received({required this.dataResponse});

  /// Data
  final DataResponse dataResponse;

  @override
  List<Object?> get props => [];
}

/// This state is emited if an error occurs
class ErrorSubmit extends OtpState {
  /// Constructor.
  ErrorSubmit({required this.message});

  /// Error message
  final String message;

  @override
  List<Object?> get props => [message];
}*/

class OtpState extends BaseState {
  OtpState({
    this.otpTextFields = const OtpText.pure(),
    this.status = FormzStatus.pure,
    this.message,
    this.data,
  });

  final OtpText otpTextFields;
  final FormzStatus status;
  final ErrorMessage? message;
  final DataResponse? data;

  @override
  List<Object?> get props => [
    otpTextFields,
    data,
    status,
    message,
  ];

  OtpState copyWith({
    OtpText? otpTextFields,
    FormzStatus? status,
    DataResponse? data,
    ErrorMessage? message,
  }) {
    return OtpState(
      otpTextFields: otpTextFields ?? this.otpTextFields,
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
