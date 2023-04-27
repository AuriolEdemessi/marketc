// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:marketscc/data/data_source/remote/authentication_services.dart'
    as _i5;
import 'package:marketscc/data/data_source/remote/home_services.dart' as _i11;
import 'package:marketscc/data/repository_impl/authentication_repository_impl.dart'
    as _i4;
import 'package:marketscc/data/repository_impl/home_repository_impl.dart'
    as _i9;
import 'package:marketscc/domain/usecase/authentication_usecase.dart' as _i6;
import 'package:marketscc/domain/usecase/home_screen_usecase.dart' as _i10;
import 'package:marketscc/export.dart' as _i3;
import 'package:marketscc/infrastructure/network/base_api_client.dart' as _i7;
import 'package:marketscc/infrastructure/network/fedapay_client.dart' as _i8;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AuthenticationRepository>(
      () => _i4.AuthenticationRepositoryImpl(gh<_i3.AuthenticationServices>()));
  gh.factory<_i5.AuthenticationServices>(() => _i5.AuthenticationServices());
  gh.factory<_i6.AuthenticationUseCase>(
      () => _i6.AuthenticationUseCase(gh<_i3.AuthenticationRepository>()));
  gh.factory<_i7.BaseApiClient>(() => _i7.BaseApiClient());
  gh.factory<_i8.FedapayClient>(() => _i8.FedapayClient());
  gh.factory<_i3.HomeScreenRepository>(
      () => _i9.HomeScreenRepositoryImpl(gh<_i3.HomeServices>()));
  gh.factory<_i10.HomeScreenUseCase>(
      () => _i10.HomeScreenUseCase(gh<_i3.HomeScreenRepository>()));
  gh.factory<_i11.HomeServices>(() => _i11.HomeServices());
  return getIt;
}
