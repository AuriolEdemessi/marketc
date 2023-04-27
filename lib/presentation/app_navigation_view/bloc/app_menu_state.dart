import 'package:equatable/equatable.dart';

import '../../../../export.dart';

class AppMenuState extends Equatable {
  final AppMenuItem appMenuItem;
  final int index;

  const AppMenuState(this.appMenuItem, this.index);

  @override
  List<Object> get props => [appMenuItem, index];
}
