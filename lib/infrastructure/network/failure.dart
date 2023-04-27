import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? debugMessage;
  final String? releaseMessage;
  const Failure({this.debugMessage, this.releaseMessage});

  @override
  List<Object?> get props => [debugMessage, releaseMessage ];
}


