import 'package:get_it/get_it.dart';

import '../data/datasource/cud/cud_data_source.dart';
import '../data/datasource/cud/cud_data_source_impl.dart';
import '../data/datasource/user/user_data_source.dart';
import '../data/datasource/user/user_data_source_impl.dart';
import '../data/repository/cud_repository_impl.dart';
import '../data/repository/user_data_repository_impl.dart';
import '../domain/repository/cud_repository.dart';
import '../domain/repository/user_repository.dart';
import '../presentation/bloc/cud_user/cud_user_bloc.dart';
import '../presentation/bloc/user/user_bloc.dart';
import '../presentation/cubit/filter_cubit.dart';
import 'appstring.dart';
import 'navigation.dart';

final sl = GetIt.instance;
final userSl = sl<UserBloc>();
final cudSl = sl<CudUserBloc>();
final filterSl = sl<FilterCubit>();

void init() {
  sl
    ..registerLazySingleton(() => AppString())
    ..registerLazySingleton(() => PageRoutes())
    //* User
    ..registerLazySingleton(() => UserBloc(sl()))
    ..registerLazySingleton<UserDataSource>(() => UserDataSourceImpl())
    ..registerLazySingleton<UserRepository>(() => UserDataRepositoryImpl(sl()))
    //* CUD
    ..registerLazySingleton<CudDataSource>(() => CudDataSourceImpl())
    ..registerLazySingleton<CudRepository>(() => CudRepositoryImpl(sl()))
    ..registerLazySingleton(() => CudUserBloc(sl()))
    //* Filter
    ..registerLazySingleton(() => FilterCubit());
}
