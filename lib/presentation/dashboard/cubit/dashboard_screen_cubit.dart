
import '../../../export.dart';

///Home Cubit that will have the repo and all the requests
class DashboardCubit extends Cubit<LoginState> {
  DashboardCubit(this.useCase) : super(LoginState());

  final AuthenticationUseCase useCase;

}
