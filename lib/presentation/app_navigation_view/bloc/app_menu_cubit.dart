
import '../../../../export.dart';

class AppMenuCubit extends Cubit<AppMenuState> {
  AppMenuCubit() : super(const AppMenuState(AppMenuItem.home, 0));

  void setNavBarItem(AppMenuItem appMenuItem) {
    switch (appMenuItem) {
      case AppMenuItem.home:
        emit(const AppMenuState(AppMenuItem.home, 0));
        break;
      case AppMenuItem.annonce:
        emit(const AppMenuState(AppMenuItem.annonce, 1));
        break;
      case AppMenuItem.exchange:
        emit(const AppMenuState(AppMenuItem.exchange, 2));
        break;
      case AppMenuItem.postAnnonce:
        emit(const AppMenuState(AppMenuItem.postAnnonce, 3));
        break;
      case AppMenuItem.purchases:
        emit(const AppMenuState(AppMenuItem.purchases, 4));
        break;
      case AppMenuItem.sales:
        emit(const AppMenuState(AppMenuItem.sales, 5));
        break;
      case AppMenuItem.profil:
        emit(const AppMenuState(AppMenuItem.profil, 6));
        break;
      case AppMenuItem.help:
        emit(const AppMenuState(AppMenuItem.help, 7));
        break;
      case AppMenuItem.feedback:
        emit(const AppMenuState(AppMenuItem.feedback, 8));
        break;
      case AppMenuItem.share:
        emit(const AppMenuState(AppMenuItem.share, 9));
        break;
      case AppMenuItem.rate:
        emit(const AppMenuState(AppMenuItem.rate, 10));
        break;
      case AppMenuItem.about:
        emit(const AppMenuState(AppMenuItem.about, 11));
        break;
      case AppMenuItem.signout:
        emit(const AppMenuState(AppMenuItem.signout, 12));
        break;
      case AppMenuItem.verification:
        emit(const AppMenuState(AppMenuItem.verification, 13));
        break;
      case AppMenuItem.faq:
        emit(const AppMenuState(AppMenuItem.faq, 14));
        break;
     case AppMenuItem.listDevise:
        emit(const AppMenuState(AppMenuItem.listDevise, 15));
        break;
     case AppMenuItem.mesAnnonces:
        emit(const AppMenuState(AppMenuItem.mesAnnonces, 16));
        break;
    }
  }
}
