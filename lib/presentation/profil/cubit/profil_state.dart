import 'package:marketscc/export.dart';

class ProfilState extends BaseState {
  ProfilState({
    this.status=FormzStatus.pure,
    this.putDevice=FormzStatus.pure,
    this.updateStatus=FormzStatus.pure,
    this.deleteStatus=FormzStatus.pure,
    this.kycVerifyStatus=FormzStatus.pure,
    this.revendeurVerifyStatus=FormzStatus.pure,
    this.uploaImage=FormzStatus.pure,
    this.userResponse,
    this.message,
    this.sucessMessage,
  });

  final ErrorMessage? message;
  final SucessMessage? sucessMessage;
  final FormzStatus status;
  final FormzStatus putDevice;
  final FormzStatus updateStatus;
  final FormzStatus deleteStatus;
  final FormzStatus kycVerifyStatus;
  final FormzStatus revendeurVerifyStatus;
  final FormzStatus uploaImage;
  final UserResponse? userResponse;

  @override
  List<Object?> get props => [
    message,
    sucessMessage,
    status,
    updateStatus,
    deleteStatus,
    putDevice,
    kycVerifyStatus,
    revendeurVerifyStatus,
    uploaImage,
    userResponse,
  ];

  ProfilState copyWith({
    ErrorMessage? message,
    SucessMessage? sucessMessage,
    FormzStatus? status,
    FormzStatus? updateStatus,
    FormzStatus? deleteStatus,
    FormzStatus? putDevice,
    FormzStatus? kycVerifyStatus,
    FormzStatus? revendeurVerifyStatus,
    FormzStatus? uploaImage,
    UserResponse? userResponse,
  }) {
    return ProfilState(
      userResponse: userResponse ?? this.userResponse,
      status: status ?? this.status,
      revendeurVerifyStatus: revendeurVerifyStatus ?? this.revendeurVerifyStatus,
      uploaImage: uploaImage ?? this.uploaImage,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      putDevice: putDevice ?? this.putDevice,
      kycVerifyStatus: kycVerifyStatus ?? this.kycVerifyStatus,
      message: message ?? this.message,
      sucessMessage: sucessMessage ?? this.sucessMessage,
    );
  }
}

