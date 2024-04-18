import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/injection.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_state.dart';
import '../list_loading_widget.dart';
import 'filter_bottom_data_widget.dart';

class FilterBottomWidget extends HookWidget {
  const FilterBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
            bloc: userSl,
            builder: (_, userState) => userState.when(
                  data: (user) {
                    final List<String> cities =
                        user.map((e) => e.city.toLowerCase()).toSet().toList();

                    return FilterBottomDataWidget(
                      cities: cities,
                    );
                  },
                  loading: () => const ListLoadingWidget(),
                  failure: (failure) => ErrorWidget(failure),
                )),
      ),
    );
  }
}
