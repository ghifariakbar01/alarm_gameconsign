import 'package:accurative/data/datasource/user_data_source_impl.dart';
import 'package:accurative/data/repository/user_data_repository_impl.dart';
import 'package:accurative/domain/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../data/datasource/user_data_source.dart';

import '../presentation/bloc/user_bloc.dart';
import 'appstring.dart';
import 'navigation.dart';

final sl = GetIt.instance;
final userSl = sl<UserBloc>();

void init() {
  sl
    ..registerLazySingleton(() => AppString())
    ..registerLazySingleton(() => PageRoutes())
    //* User
    ..registerLazySingleton(() => UserBloc(sl()))
    ..registerLazySingleton<UserDataSource>(() => UserDataSourceImpl())
    ..registerLazySingleton<UserRepository>(() => UserDataRepositoryImpl(sl()));
}
