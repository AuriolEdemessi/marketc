/*
import 'package:marketscc/export.dart';
import 'package:equatable/equatable.dart';


/// Base class for user states
abstract class PortefeuilleSate extends Equatable {}

/// Initial state
class PortefeuilleInitial extends PortefeuilleSate {
  @override
  List<Object?> get props => [];
}

/// This state is emited while data is fetching
class FetchingPortefeuilleData extends PortefeuilleSate {
  @override
  List<Object?> get props => [];
}


class SubmissionInProgress extends PortefeuilleSate {
  @override
  List<Object?> get props => [];
}

/// This state is emited when data is received.
class ReceivedPortefeuilleData extends PortefeuilleSate {
  /// Constructor.
  ReceivedPortefeuilleData({required this.userData});

  /// Data
  final UserResponse userData;

  @override
  List<Object?> get props => [userData];
}


/// This state is emited if an error occurs
class ErrorUserData extends UserState {
  /// Constructor.
  ErrorUserData({required this.message});

  /// Error message
  final ErrorMessage message;

  @override
  List<Object?> get props => [message];
}
*/


import 'package:marketscc/data/models/user_model.dart';

import '../../../../export.dart';

class PortefeuillesState extends BaseState {
  PortefeuillesState({
    this.currrencyTypeListStatus=FormzStatus.pure,
    this.createWalletStatus=FormzStatus.pure,
    this.deteleWalletStatus=FormzStatus.pure,
    this.currrencyTypeList,
    this.user,
    this.message,
    this.updateMessage,
  });

  final ErrorMessage? message;
  final String? updateMessage;
  final FormzStatus currrencyTypeListStatus;
  final FormzStatus createWalletStatus;
  final FormzStatus deteleWalletStatus;
  final List<CurrencyType>? currrencyTypeList;
  final UserModel? user;

  @override
  List<Object?> get props => [
    message,
    updateMessage,
    currrencyTypeList,
    user,
    createWalletStatus,
    deteleWalletStatus,
    currrencyTypeListStatus,
  ];

  PortefeuillesState copyWith({
    ErrorMessage? message,
    String? updateMessage,
    FormzStatus? currrencyTypeListStatus,
    UserModel? user,
    FormzStatus? createWalletStatus,
    FormzStatus? deteleWalletStatus,
    List<CurrencyType>? currrencyTypeList,
  }) {
    return PortefeuillesState(
      currrencyTypeListStatus: currrencyTypeListStatus ?? this.currrencyTypeListStatus,
      createWalletStatus: createWalletStatus ?? this.createWalletStatus,
      deteleWalletStatus: deteleWalletStatus ?? this.deteleWalletStatus,
      currrencyTypeList: currrencyTypeList ?? this.currrencyTypeList,
      message: message ?? this.message,
      updateMessage: updateMessage ?? this.updateMessage,
      user: user ?? this.user,
    );
  }
}