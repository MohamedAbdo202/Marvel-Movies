import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_task/Features/Auth/data/datasources/localDataSources.dart';
import 'package:movie_task/Features/Auth/presentation/Cubit/CubitAuth.dart';
import 'package:movie_task/Features/Movies/data/datasources/movie_local_data_source%5D.dart';
import 'package:movie_task/Features/Movies/data/datasources/movie_remote_data_source.dart';
import 'package:movie_task/Features/Movies/data/repoistories/movie_repository_impl.dart';
import 'package:movie_task/Features/Movies/domain/repoistories/Movie_repositry.dart';
import 'package:movie_task/Features/Movies/domain/usecases/get_all_byPage.dart';
import 'package:movie_task/Features/Movies/presentation/Bloc/Movie_Bloc.dart';
import 'package:movie_task/core/network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Features/Auth/data/datasources/remoteDataFirebase.dart';
import 'Features/Auth/data/repoistory/remoteDataimpl.dart';
import 'Features/Auth/domain/repositories/AuthRepository.dart';
import 'Features/Auth/domain/usecases/LoginUseCase.dart';
import 'Features/Movies/domain/usecases/get_all_TvByPage.dart';

final sl =GetIt.instance;
Future<void> init()async{
//  Features -- Movies
//Bloc
sl.registerFactory(() => MovieCubit(getByPageUseCase: sl(),getByPageTvUseCase: sl()));
sl.registerFactory(() =>AuthCubit(loginUseCase: sl(),registerWithEmailAndPassword: sl()));

// Usecases

sl.registerLazySingleton(() => GetByPageUseCase(sl()));
  sl.registerLazySingleton(() => GetByPageTvUseCase(sl()));

//Auth Usecases
  sl.registerLazySingleton(() => SignInWithEmailAndPassword(sl()));
  sl.registerLazySingleton(() => RegisterWithEmailAndPassword(sl()));


// Repositries
sl.registerLazySingleton<MovieRepository>(() => MovieRepoistoryImpl(
    remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<AuthRepository>(() => RemoteRepoistoryImpl(authRemote: sl(),authLocalDataSource: sl()));

// DataSources

sl.registerLazySingleton<MovieRemoteDataSource>(() =>
    MovieRemoteImplWithDio(dio: sl()));
  sl.registerLazySingleton<MovieLocalDataSource>(() =>
      MovieLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(() =>
      AuthLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<AuthRemote>(() => AuthImplWithFirebase());


// Core
sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

// External
final sharedPreferences =await SharedPreferences.getInstance();
sl.registerLazySingleton(() => sharedPreferences);
sl.registerLazySingleton(() => Dio());
sl.registerLazySingleton(() => InternetConnectionChecker());


}