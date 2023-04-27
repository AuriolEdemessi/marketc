import 'dart:math';

import '../../../export.dart';


class CodeCubit extends Cubit<CodeState> {
  final HomeScreenUseCase useCase;
  CodeCubit(this.useCase) : super(CodeState());


}
