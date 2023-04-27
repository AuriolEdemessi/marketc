import 'package:get/get.dart';

import '../../export.dart';

class AppPages {
  static final unknownRoutePage = GetPage(name: RoutePaths.unknown, page: () => UnknowScreen());

  static final List<GetPage> pages = [
    unknownRoutePage,
    GetPage(
      name: RoutePaths.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RoutePaths.loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
        name: RoutePaths.dashboardScreen,
        page: () => DashboardScreen(),
    ),
  ];

  static myOffAllNamed(routePath) async {
    await 2.delay();
    Get.offAllNamed(routePath);
  }
}