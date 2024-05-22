import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../features/auth/data/data_sources/local_data_source.dart';
import '../../features/auth/data/data_sources/remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repo_impl.dart';
import '../../features/auth/domain/repositories/auth_repo.dart';
import '../../features/todos/data/data_sources/local_repo.dart';
import '../../features/todos/data/data_sources/remote_repo.dart';
import '../../features/todos/data/repositories/todo_repo_impl.dart';
import '../../features/todos/domain/repositories/todo_repo.dart';
import '../connection/network_info.dart';
import '../databases/api/dio_consumer.dart';
import '../databases/cache/cache_helper.dart';

final GetIt getIt = GetIt.instance;

void initDependencies() {
// Register CacheHelper
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());

  // Register InternetConnection
  getIt.registerLazySingleton<InternetConnection>(() => InternetConnection());

  // Register NetworkInfoImpl
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(getIt<InternetConnection>()));

  // Register Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register DioConsumer
  getIt
      .registerLazySingleton<DioConsumer>(() => DioConsumer(dio: getIt<Dio>()));

  // Register AuthLocalDataSource
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(cache: getIt<CacheHelper>()));

  // Register AuthRemoteDataSource
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(api: getIt<DioConsumer>()));

  // Register AuthRepoImpl
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
        localDataSource: getIt<AuthLocalDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
        remoteDataSource: getIt<AuthRemoteDataSource>(),
      ));

  // Register TodoLocalRepo
  getIt.registerLazySingleton<TodoLocalRepo>(
      () => TodoLocalRepo(cacheHelper: getIt<CacheHelper>()));

  // Register TodoRemoteRepo
  getIt.registerLazySingleton<TodoRemoteRepo>(
      () => TodoRemoteRepo(api: getIt<DioConsumer>()));

  // Register TodoRepoImpl
  getIt.registerLazySingleton<TodoRepo>(() => TodoRepoImpl(
        networkInfo: getIt<NetworkInfo>(),
        localDataSource: getIt<TodoLocalRepo>(),
        remoteSource: getIt<TodoRemoteRepo>(),
      ));
}
