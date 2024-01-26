// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i14;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../../modules/khatmat/data/datasource/khatma_local_data_source_impl.dart'
    as _i6;
import '../../modules/khatmat/data/datasource/khatma_remote_data_source_impl.dart'
    as _i16;
import '../../modules/khatmat/domain/blocs/khatma_cubit.dart' as _i24;
import '../../modules/khatmat/domain/repo/khatma_repository_impl.dart' as _i20;
import '../../modules/library/data/datasource/library_local_data_source_impl.dart'
    as _i7;
import '../../modules/library/data/datasource/library_remote_data_source_impl.dart'
    as _i17;
import '../../modules/library/domain/blocs/library_cubit.dart' as _i27;
import '../../modules/library/domain/repo/library_repository_impl.dart' as _i21;
import '../../modules/recitations/data/datasource/recitation_local_data_source_impl.dart'
    as _i8;
import '../../modules/recitations/data/datasource/recitation_remote_data_source_impl.dart'
    as _i18;
import '../../modules/recitations/domain/blocs/recitation_cubit.dart' as _i25;
import '../../modules/recitations/domain/repo/recitation_repository_impl.dart'
    as _i22;
import '../../modules/reciter/data/datasource/reciter_local_data_source_impl.dart'
    as _i9;
import '../../modules/reciter/data/datasource/reciter_remote_data_source_impl.dart'
    as _i19;
import '../../modules/reciter/domain/blocs/reciter_cubit.dart' as _i26;
import '../../modules/reciter/domain/repo/reciter_repository_impl.dart' as _i23;
import '../helpers/hlp_shared_preference.dart' as _i11;
import '../managers/audio/audio_controller.dart' as _i4;
import '../managers/localization/app_language.dart' as _i12;
import '../managers/navigation/app_navigator.dart' as _i3;
import '../managers/network/dio_client.dart' as _i15;
import '../managers/theme/app_them_manager.dart' as _i13;
import 'module/local_module.dart' as _i28;
import 'module/network_module.dart' as _i29;

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
  gh.singleton<_i4.AudioController>(_i4.AudioController());
  await gh.factoryAsync<_i5.InternetConnectionChecker>(
    () => localModule.checker,
    preResolve: true,
  );
  gh.singleton<_i6.KhatmaLocalDataSource>(const _i6.KhatmaLocalDataSource());
  gh.singleton<_i7.LibraryLocalDataSource>(const _i7.LibraryLocalDataSource());
  gh.singleton<_i8.RecitationLocalDataSource>(
      const _i8.RecitationLocalDataSource());
  gh.singleton<_i9.ReciterLocalDataSource>(const _i9.ReciterLocalDataSource());
  await gh.factoryAsync<_i10.SharedPreferences>(
    () => localModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i11.SharedPreferenceHelper>(
      _i11.SharedPreferenceHelper(gh<_i10.SharedPreferences>()));
  gh.singleton<_i12.AppLanguageManager>(
    _i12.AppLanguageManager(gh<_i11.SharedPreferenceHelper>()),
    dispose: (i) => i.disposeManager(),
  );
  gh.singleton<_i13.AppThemeManager>(
    _i13.AppThemeManager(gh<_i11.SharedPreferenceHelper>()),
    dispose: (i) => i.disposeManager(),
  );
  gh.lazySingletonAsync<_i14.Dio>(
      () => serviceModule.getDio(gh<_i11.SharedPreferenceHelper>()));
  gh.singletonAsync<_i15.DioClient>(
      () async => _i15.DioClient(await gh.getAsync<_i14.Dio>()));
  gh.singletonAsync<_i16.KhatmaRemoteDataSource>(() async =>
      _i16.KhatmaRemoteDataSource(await gh.getAsync<_i15.DioClient>()));
  gh.singletonAsync<_i17.LibraryRemoteDataSource>(() async =>
      _i17.LibraryRemoteDataSource(await gh.getAsync<_i15.DioClient>()));
  gh.singletonAsync<_i18.RecitationRemoteDataSource>(() async =>
      _i18.RecitationRemoteDataSource(await gh.getAsync<_i15.DioClient>()));
  gh.singletonAsync<_i19.ReciterRemoteDataSource>(() async =>
      _i19.ReciterRemoteDataSource(await gh.getAsync<_i15.DioClient>()));
  gh.singletonAsync<_i20.ImplKhatmaRepository>(
      () async => _i20.ImplKhatmaRepository(
            gh<_i5.InternetConnectionChecker>(),
            await gh.getAsync<_i16.KhatmaRemoteDataSource>(),
            gh<_i6.KhatmaLocalDataSource>(),
          ));
  gh.singletonAsync<_i21.ImplLibraryRepository>(
      () async => _i21.ImplLibraryRepository(
            gh<_i5.InternetConnectionChecker>(),
            await gh.getAsync<_i17.LibraryRemoteDataSource>(),
            gh<_i7.LibraryLocalDataSource>(),
          ));
  gh.singletonAsync<_i22.ImplRecitationRepository>(
      () async => _i22.ImplRecitationRepository(
            gh<_i5.InternetConnectionChecker>(),
            await gh.getAsync<_i18.RecitationRemoteDataSource>(),
            gh<_i8.RecitationLocalDataSource>(),
          ));
  gh.singletonAsync<_i23.ImplReciterRepository>(
      () async => _i23.ImplReciterRepository(
            gh<_i5.InternetConnectionChecker>(),
            await gh.getAsync<_i19.ReciterRemoteDataSource>(),
            gh<_i9.ReciterLocalDataSource>(),
          ));
  gh.singletonAsync<_i24.KhatmaCubit>(() async =>
      _i24.KhatmaCubit(await gh.getAsync<_i20.ImplKhatmaRepository>()));
  gh.singletonAsync<_i25.RecitationCubit>(() async =>
      _i25.RecitationCubit(await gh.getAsync<_i22.ImplRecitationRepository>()));
  gh.singletonAsync<_i26.ReciterCubit>(() async =>
      _i26.ReciterCubit(await gh.getAsync<_i23.ImplReciterRepository>()));
  gh.singletonAsync<_i27.LibraryCubit>(() async =>
      _i27.LibraryCubit(await gh.getAsync<_i21.ImplLibraryRepository>()));
  return getIt;
}

class _$LocalModule extends _i28.LocalModule {}

class _$ServiceModule extends _i29.ServiceModule {}
