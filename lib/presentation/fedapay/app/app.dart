import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../view/widget_builder_view.dart';

@StackedApp(
  logger: StackedLogger(),
  routes: [
    MaterialRoute(page: WebViewPay),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
  ],
)
class App {
  // Serves no purpose but for annotations to work
}
