// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../../modules/khatmat/data/datasource/khatma_local_data_source_impl.dart'
    as _i5;
import '../../modules/khatmat/data/datasource/khatma_remote_data_source_impl.dart'
    as _i14;
import '../../modules/khatmat/domain/blocs/khatma_cubit.dart' as _i20;
import '../../modules/khatmat/domain/repo/khatma_repository_impl.dart' as _i17;
import '../../modules/recitations/data/datasource/recitation_local_data_source_impl.dart'
    as _i6;
import '../../modules/recitations/data/datasource/recitation_remote_data_source_impl.dart'
    as _i15;
import '../../modules/recitations/domain/blocs/recitation_cubit.dart' as _i21;
import '../../modules/recitations/domain/repo/recitation_repository_impl.dart'
    as _i18;
import '../../modules/reciter/data/datasource/reciter_local_data_source_impl.dart'
    as _i7;
import '../../modules/reciter/data/datasource/reciter_remote_data_source_impl.dart'
    as _i16;
import '../../modules/reciter/domain/blocs/reciter_cubit.dart' as _i22;
import '../../modules/reciter/domain/repo/reciter_repository_impl.dart' as _i19;
import '../helpers/hlp_shared_preference.dart' as _i9;
import '../managers/localization/app_language.dart' as _i10;
import '../managers/navigation/app_navigator.dart' as _i3;
import '../managers/network/dio_client.dart' as _i13;
import '../managers/theme/app_them_manager.dart' as _i11;
import 'module/local_module.dart' as _i23;
import 'module/network_module.dart' as _i24;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final localModule = _$LocalModule();
  final serviceModule = _$ServiceModule();
  gh.singleton<_i3.AppNavigator>(_i3.AppNavigator());
  await gh.factoryAsync<_i4.InternetConnectionChecker>(
    () => localModule.checker,
    preResolve: true,
  );
  gh.singleton<_i5.KhatmaLocalDataSource>(const _i5.KhatmaLocalDataSource());
  gh.singleton<_i6.RecitationLocalDataSource>(
      const _i6.RecitationLocalDataSource());
  gh.singleton<_i7.ReciterLocalDataSource>(const _i7.ReciterLocalDataSource());
  await gh.factoryAsync<_i8.SharedPreferences>(
    () => localModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i9.SharedPreferenceHelper>(
      _i9.SharedPreferenceHelper(gh<_i8.SharedPreferences>()));
  gh.singleton<_i10.AppLanguageManager>(
    _i10.AppLanguageManager(gh<_i9.SharedPreferenceHelper>()),
    dispose: (i) => i.disposeManager(),
  );
  gh.singleton<_i11.AppThemeManager>(
    _i11.AppThemeManager(gh<_i9.SharedPreferenceHelper>()),
    dispose: (i) => i.disposeManager(),
  );
  gh.lazySingletonAsync<_i12.Dio>(
      () => serviceModule.getDio(gh<_i9.SharedPreferenceHelper>()));
  gh.singletonAsync<_i13.DioClient>(
      () async => _i13.DioClient(await gh.getAsync<_i12.Dio>()));
  gh.singletonAsync<_i14.KhatmaRemoteDataSource>(() async =>
      _i14.KhatmaRemoteDataSource(await gh.getAsync<_i13.DioClient>()));
  gh.singletonAsync<_i15.RecitationRemoteDataSource>(() async =>
      _i15.RecitationRemoteDataSource(await gh.getAsync<_i13.DioClient>()));
  gh.singletonAsync<_i16.ReciterRemoteDataSource>(() async =>
      _i16.ReciterRemoteDataSource(await gh.getAsync<_i13.DioClient>()));
  gh.singletonAsync<_i17.ImplKhatmaRepository>(
      () async => _i17.ImplKhatmaRepository(
            gh<_i4.InternetConnectionChecker>(),
            await gh.getAsync<_i14.KhatmaRemoteDataSource>(),
            gh<_i5.KhatmaLocalDataSource>(),
          ));
  gh.singletonAsync<_i18.ImplRecitationRepository>(
      () async => _i18.ImplRecitationRepository(
            gh<_i4.InternetConnectionChecker>(),
            await gh.getAsync<_i15.RecitationRemoteDataSource>(),
            gh<_i6.RecitationLocalDataSource>(),
          ));
  gh.singletonAsync<_i19.ImplReciterRepository>(
      () async => _i19.ImplReciterRepository(
            gh<_i4.InternetConnectionChecker>(),
            await gh.getAsync<_i16.ReciterRemoteDataSource>(),
            gh<_i7.ReciterLocalDataSource>(),
          ));
  gh.singletonAsync<_i20.KhatmaCubit>(() async =>
      _i20.KhatmaCubit(await gh.getAsync<_i17.ImplKhatmaRepository>()));
  gh.singletonAsync<_i21.RecitationCubit>(() async =>
      _i21.RecitationCubit(await gh.getAsync<_i18.ImplRecitationRepository>()));
  gh.singletonAsync<_i22.ReciterCubit>(() async =>
      _i22.ReciterCubit(await gh.getAsync<_i19.ImplReciterRepository>()));
  return getIt;
}

class _$LocalModule extends _i23.LocalModule {}

class _$ServiceModule extends _i24.ServiceModule {}
