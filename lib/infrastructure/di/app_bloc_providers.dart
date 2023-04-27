import 'package:flutter_bloc/src/bloc_provider.dart';

import '../../export.dart';


///This will hold every bloc provider that will be used across the app
List<BlocProviderSingleChildWidget> get appProviders => [
      BlocProvider(create: (_) => AppMenuCubit()),
      BlocProvider(create: (_) => IntroCubit(getIt.get())),
      BlocProvider(create: (_) => SplashScreenCubit(getIt.get())),
      BlocProvider(create: (_) => LoginCubit(getIt.get())),
      BlocProvider(create: (_) => SignupCubit(getIt.get())),
      BlocProvider(create: (_) => FaqCubit(getIt.get())),
      BlocProvider(create: (_) => ProfilCubit(getIt.get())),
      BlocProvider(create: (_) => AnnonceCubit(getIt.get())),
      BlocProvider(create: (_) => PasswordChangedCubit(getIt.get())),
      BlocProvider(create: (_) => HomeCubit(authenticationUseCase: getIt.get(), homeScreenUseCase: getIt.get())),
    ];
