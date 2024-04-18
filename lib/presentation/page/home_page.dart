import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/route_manager.dart';

import '../../core/routes.dart';
import '../../style/style.dart';
import '../bloc/user/user_bloc.dart';
import '../bloc/user/user_state.dart';
import '../widget/home_appbar_widget.dart';
import '../widget/list_loading_widget.dart';
import '../widget/user_list_widget.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: const HomeAppBarWidget(),
        body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) => state.map(
                data: (value) {
                  final data = value.user;
                  if (data.isEmpty) return Container();
                  return UserListWidget(
                    data: data,
                  );
                },
                loading: (_) => const ListLoadingWidget(),
                failure: (value) => ErrorWidget(value))),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.insertPage);
          },
          backgroundColor: Palette.secondaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
