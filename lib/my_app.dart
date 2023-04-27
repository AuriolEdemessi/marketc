import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'export.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return  ScreenUtilInit(
        designSize: const Size(375.0, 667.0),
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => AppMenuCubit()),
              BlocProvider(create: (_) => IntroCubit(getIt.get())),
              BlocProvider(create: (_) => SplashScreenCubit(getIt.get())),
              BlocProvider(create: (_) => LoginCubit(getIt.get())),
              BlocProvider(create: (_) => SignupCubit(getIt.get())),
              BlocProvider(create: (_) => FaqCubit(getIt.get())),
              BlocProvider(create: (_) => ProfilCubit(getIt.get())),
              BlocProvider(create: (_) => AnnonceCubit(getIt.get())),
              BlocProvider(create: (_) => PasswordChangedCubit(getIt.get())),
              BlocProvider(create: (_) => PassForgotCubit(getIt.get())),
              BlocProvider(create: (_) => ExchangeCubit(getIt.get())),
              BlocProvider(create: (_) => FeebakCubit(getIt.get())),
              BlocProvider(create: (_) => CodeCubit(getIt.get())),
              BlocProvider(create: (_) => SalesCubit(getIt.get())),
              BlocProvider(create: (_) => PurchaseCubit(getIt.get())),
              BlocProvider(create: (_) => PortefeuillesCubit(homeScreenUseCase: getIt.get(), authenticationUseCase: getIt.get())),
              BlocProvider(create: (_) => OtpCubit(getIt.get())),
              BlocProvider(create: (_) => PaymentCubit(getIt.get())),
              BlocProvider(create: (_) => MesAnnoncesCubit(getIt.get())),
              BlocProvider(create: (_) => NewPasswordCubit(getIt.get())),
              BlocProvider(create: (_) => AffiliationCubit(getIt.get())),
              BlocProvider(create: (_) => FedapayCubit(getIt.get())),
              BlocProvider(create: (_) => HomeCubit(authenticationUseCase: getIt.get(), homeScreenUseCase: getIt.get())),
              BlocProvider(create: (_) => NotificationCubit(getIt.get())),
            ],
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
              theme: ThemeData(
                primaryColor: AppColors.primary,
                brightness: Brightness.light,
                visualDensity: VisualDensity.standard,
                primarySwatch: Colors.blue,
                //primarySwatch: getMaterialColor(AppColors.primary),
                scaffoldBackgroundColor: Colors.transparent,
              ),
              initialRoute: RoutePaths.splashScreen,
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case RoutePaths.loginScreen:
                    return MaterialPageRoute(builder: (_) => const LoginScreen());

                  case RoutePaths.passForgotScreen:
                    return MaterialPageRoute(builder: (_) => const PassForgotScreen());

                  case RoutePaths.signupScreen:
                    return MaterialPageRoute(builder: (_) => SignupScreen());

                  case RoutePaths.splashScreen:
                    return MaterialPageRoute(builder: (_) => SplashScreen());

                  case RoutePaths.dashboardScreen:
                    return MaterialPageRoute(builder: (_) => DashboardScreen());

                  case RoutePaths.postAnnonce:
                    return MaterialPageRoute(builder: (_) => PostAnnonceScreen(currencyExchange: settings.arguments as CurrencyExchange,));

                  case RoutePaths.exchange:
                    return MaterialPageRoute(builder: (_) => ExchangeScreen(annonceModel: settings.arguments as AnnonceModel,));

                  case RoutePaths.proofScreen:
                    return MaterialPageRoute(builder: (_) => ProofScreen(buyInfo: settings.arguments as BuyInfo,));


                  case RoutePaths.introScreen:
                    return MaterialPageRoute(builder: (_) => IntroductionScreen());

                  case RoutePaths.resumeExchange:
                    return MaterialPageRoute(builder: (_) => ResumeExchange( exchangeBuyCoin:  settings.arguments as ExchangeBuyCoin,));


                  case RoutePaths.wallet:
                    return MaterialPageRoute(builder: (_) => WalletPage( wallet:  settings.arguments as List<Wallet>,));


                  case RoutePaths.ebuyPayScreen:
                    return MaterialPageRoute(builder: (_) => EbuyPayScreen( buyCoinResponse: settings.arguments as BuyCoinResponse,));

                  case RoutePaths.editAnnonce:
                    return MaterialPageRoute(builder: (_) => EditAnnonce( mesAnnonce:  settings.arguments as MesAnnonceModel,));

                  case RoutePaths.codeOtpScreen:
                    return MaterialPageRoute(builder: (_) => CodeOtpScreen(email: settings.arguments as String));

                  case RoutePaths.codeOtpScreen:
                    return MaterialPageRoute(builder: (_) => CodeOtpScreen(email: settings.arguments as String));


                  case RoutePaths.passForgotScreen:
                    return MaterialPageRoute(builder: (_) => PassForgotScreen());


                  case RoutePaths.passForgotScreen:
                    return MaterialPageRoute(builder: (_) => HelpScreen());


                  case RoutePaths.newPasswordResetSreen:
                    return MaterialPageRoute(builder: (_) => NewPasswordResetScreen(token:settings.arguments as String));
                  default:
                    return MaterialPageRoute(builder: (_) {
                      return const Scaffold(
                        body: Center(
                          child: Text('Page not found :('),
                        ),
                      );
                    });
                }
              },
            ),
          );
        });
  }
}
