import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:iGenTech/core/helpers/secure_cache_helper.dart';
import 'package:iGenTech/core/services/geo_location_service.dart';
import 'package:iGenTech/core/services/permission_service.dart';
import 'package:iGenTech/core/validations/bio_metric_auth.dart';
import 'package:iGenTech/features/first_feature/data/data_sources/first_feature_remote_data_source.dart';
import 'package:iGenTech/features/first_feature/data/repositories/first_feature_repo_impl.dart';
import 'package:iGenTech/features/first_feature/domain/repositories/first_feature_repo.dart';
import 'package:iGenTech/features/first_feature/domain/use_cases/first_feature_uc.dart';
import 'package:iGenTech/features/first_feature/presentation/manager/cat_fact_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:iGenTech/features/onBoarding/presentation/manager/onboarding_cubit.dart';
import 'package:iGenTech/features/profile/data/data_sources/profile_local_data_source.dart';
import 'package:iGenTech/features/profile/data/repositories/profile_repository_imp.dart';
import 'package:iGenTech/features/profile/domain/repositories/profile_repository.dart';
import 'package:iGenTech/features/profile/domain/use_cases/get_profile_uc.dart';
import 'package:iGenTech/features/profile/presentation/manager/profile_cubit.dart';
import 'package:iGenTech/features/sign_in/data/data_sources/sign_in_local_data_source.dart';
import 'package:iGenTech/features/sign_in/data/repositories/sign_in_repository_imp.dart';
import 'package:iGenTech/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:iGenTech/features/sign_in/domain/use_cases/sign_in_uc.dart';
import 'package:iGenTech/features/sign_in/presentation/manager/sign_in_cubit.dart';
import 'package:iGenTech/features/sign_up/data/data_sources/sign_up_data_local_source.dart';
import 'package:iGenTech/features/sign_up/data/repositories/sign_up_repository_imp.dart';
import 'package:iGenTech/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:iGenTech/features/sign_up/domain/use_cases/check_email_uc.dart';
import 'package:iGenTech/features/sign_up/domain/use_cases/sign_up_uc.dart';
import 'package:iGenTech/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:iGenTech/features/splash/presentation/manager/splash_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/helpers/shared_prefrences.dart';
import 'core/network/netwok_info.dart';
import 'core/services/alert_service.dart';
import 'core/services/url_launcher_service.dart';

final getIt = GetIt.instance;

Future<void> getItInit() async {
  //! Features

  /// Blocs
  getIt.registerFactory<CatFactCubit>(() => CatFactCubit(featureUc: getIt()));
  getIt.registerFactory<SplashCubit>(() => SplashCubit( getIt()));
  getIt.registerFactory<SignInCubit>(() => SignInCubit(signInUseCase: getIt() ,biometricAuth: getIt()));
  getIt.registerFactory<OnBoardingCubit>(() => OnBoardingCubit( getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit( urlLauncherService: getIt(),getProfileUseCase: getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(signUpUseCase: getIt(),checkEmailUseCase: getIt(),biometricAuth: getIt(),permissionService: getIt(),locationService: getIt() ));

  /// Use cases
  getIt
      .registerLazySingleton<FirstFeatureUc>(() => FirstFeatureUc(firstFeatureRepository: getIt()));
  getIt.registerLazySingleton<SignUpUseCase>(
        () => SignUpUseCaseImpl(getIt()),
  ); getIt.registerLazySingleton<SignInUseCase>(
        () => SignInUseCaseImpl(getIt()),
  );

  getIt.registerLazySingleton(
        () => CheckEmailUseCase(getIt()),
  ); getIt.registerLazySingleton(
        () => GetProfileUseCase(getIt()),
  );
  /// Repository
  getIt.registerLazySingleton<FirstFeatureRepository>(() =>
      FirstFeatureRepositoryImpl(networkInfo: getIt(), firstFeatureRemoteDataSource: getIt()));
  getIt.registerLazySingleton<SignUpRepository>(
        () => SignUpRepositoryImpl(localDataSource: getIt()),
  );  getIt.registerLazySingleton<SignInRepository>(
        () => SignInRepositoryImpl(localDataSource: getIt()),
  );getIt.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl( getIt()),
  );
  /// Data Sources
  getIt.registerLazySingleton<FirstFeatureRemoteDataSource>(
      () => FirstFeatureRemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<SignUpLocalDataSource>(
        () =>SignUpLocalDataSourceImpl(getIt()),
  );
 getIt.registerLazySingleton<SignInLocalDataSource>(
        () =>SignInLocalDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<ProfileLocalDataSource>(
        () =>ProfileLocalDataSourceImpl(getIt()),
  );
  /// Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: getIt()));
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: getIt()));

  /// External
  SharedPreferences preferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => preferences);
  getIt.registerLazySingleton(() => AppInterceptors());
  // getIt.registerLazySingleton(() => LogInterceptor(
  //     request: true,
  //     requestBody: true,
  //     requestHeader: true,
  //     responseBody: true,
  //     responseHeader: false,
  //     error: true));
  getIt.registerLazySingleton(() => InternetConnectionChecker());
  getIt.registerLazySingleton(() => CacheHelper());
  getIt.registerLazySingleton(() => UrlLauncherService());
  getIt.registerLazySingleton(() => PermissionService());
  getIt.registerLazySingleton(() => AlertService());
  getIt.registerLazySingleton(() => BiometricAuth());
  getIt.registerLazySingleton(() => SecureCacheHelper());
  getIt.registerLazySingleton(() => LocationService());

  getIt.registerLazySingleton(() => PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ));
  getIt.registerLazySingleton(() => Dio());
}
