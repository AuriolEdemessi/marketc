import '../../../export.dart';

import 'package:marketscc/export.dart';
import 'package:equatable/equatable.dart';


/*/// Base class for user states
abstract class HomeState extends Equatable {}

/// Initial state
class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

/// This state is emited while data is fetching
class FetchingData extends HomeState {
  @override
  List<Object?> get props => [];
}

/// This state is emited when data is received.
class ReceivedData extends HomeState {
  /// Constructor.
  ReceivedData({this.accountModel});

  /// Data
  final TrxResponse? accountModel;

  @override
  List<Object?> get props => [accountModel];
}

/// This state is emited if an error occurs
class ErrorData extends HomeState {
  /// Constructor.
  ErrorData({required this.message});

  /// Error message
  final ErrorMessage message;

  @override
  List<Object?> get props => [message];
}*/



class HomeState extends BaseState {
  HomeState({
    this.trxResponse,
    this.brandImage,
    this.errorMessage,
    this.trxStatus=FormzStatus.pure,
    this.brandStatus=FormzStatus.pure,
  });


  final ErrorMessage? errorMessage;
  final FormzStatus trxStatus;
  final TrxResponse? trxResponse;
  final BrandList? brandImage;
  final FormzStatus brandStatus;

  @override
  List<Object?> get props => [
    errorMessage,
    trxStatus,
    brandStatus,
    brandImage,
    trxResponse,
  ];

  HomeState copyWith({
    FormzStatus? trxStatus,
    ErrorMessage? errorMessage,
    TrxResponse? trxResponse,
    FormzStatus? brandStatus,
    BrandList? brandImage,
  }) {
    return HomeState(
      trxStatus: trxStatus ?? this.trxStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      trxResponse: trxResponse ?? this.trxResponse,
      brandImage: brandImage ?? this.brandImage,
      brandStatus: brandStatus ?? this.brandStatus,
    );
  }
}
