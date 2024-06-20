import 'package:alarm/core/injection.dart';
import 'package:alarm/presentation/bloc/notif_setup/notif_setup_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/route_manager.dart';

import '../../core/routes.dart';
import '../../style/style.dart';
import '../bloc/alarm/alarm_bloc.dart';
import '../bloc/alarm/alarm_state.dart';
import '../bloc/notif_setup/notif_setup_bloc.dart';
import '../bloc/notif_setup/notif_setup_state.dart';
import '../widget/home_appbar_widget.dart';
import '../widget/list_loading_widget.dart';
import '../widget/alarm_list_widget.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: BlocConsumer<NotifSetupBloc, NotifSetupState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            success: () => _onSuccess(context),
          );
        },
        builder: (context, state) => Scaffold(
            backgroundColor: Colors.black,
            appBar: const HomeAppBarWidget(),
            body: state.when(
              success: () => BlocBuilder<AlarmBloc, AlarmState>(
                builder: (context, stateAlarm) => stateAlarm.map(
                    data: (value) {
                      final data = value.data;
                      if (data.isEmpty) {
                        return Center(
                            child: Text(
                          'Looks like there`s nothing here...',
                          style: Themes.font(
                            20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ));
                      }
                      return AlarmListWidget(
                        data: [...data.reversed],
                      );
                    },
                    loading: (_) => const ListLoadingWidget(),
                    failure: (value) => ErrorWidget(value.failure.message)),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (failure) => Center(
                child: TextButton(
                  onPressed: () {
                    notifSetupSl.add(Setup());
                  },
                  child: Text(
                    'Tap to retry notification.',
                    style: Themes.font(
                      20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: state.maybeWhen(
              orElse: () => Container(),
              success: () => FloatingActionButton(
                onPressed: () {
                  Get.toNamed(Routes.insertPage);
                },
                backgroundColor: Colors.green,
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            )),
      ),
    );
  }

  _onSuccess(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Notifikasi On',
          style: Themes.font(
            15,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
