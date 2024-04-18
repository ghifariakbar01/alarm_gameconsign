import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/bloc/cud_user/cud_user_bloc.dart';
import '../presentation/bloc/user/user_bloc.dart';
import '../presentation/cubit/filter_cubit.dart';
import 'injection.dart';

class Providers {
  final BuildContext context;

  Providers(this.context);

  List<BlocProvider> get providers => _providers;

  final List<BlocProvider> _providers = [
    BlocProvider<FilterCubit>(
      create: (BuildContext context) => FilterCubit(),
    ),
    BlocProvider<CudUserBloc>(
      create: (BuildContext context) => CudUserBloc(sl()),
    ),
    BlocProvider<UserBloc>(
      create: (BuildContext context) => userSl..add(GetUser()),
    ),
  ];
}
