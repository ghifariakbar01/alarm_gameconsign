// ignore_for_file: use_build_context_synchronously

import 'package:alarm/presentation/bloc/alarm/alarm_event.dart';
import 'package:alarm/presentation/bloc/notif/notif_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../core/injection.dart';
import '../../data/model/alarm_model.dart';
import '../../style/style.dart';

import '../bloc/cud_alarm/cud_alarm_bloc.dart';
import '../bloc/cud_alarm/cud_alarm_event.dart';
import '../bloc/cud_alarm/cud_alarm_state.dart';

import '../widget/common_widget.dart';

class InsertPage extends HookWidget {
  const InsertPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);

    final namaController = useTextEditingController();
    final dateController = useTextEditingController();
    final dateTime = useState(DateTime.now());

    return BlocConsumer<CudAlarmBloc, CudAlarmState>(
      bloc: cudSl,
      listener: (_, state) {
        state.maybeWhen(
          orElse: () {},
          success: () => _onSuccess(context),
          failure: (failure) => _onFailure(
            context,
            failure.message,
          ),
        );
      },
      builder: (_, state) => state.maybeWhen(
          loading: () => const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          failure: (failure) => ErrorWidget(failure),
          orElse: () => KeyboardDismissOnTap(
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      toolbarHeight: 80,
                      backgroundColor: Colors.black,
                      title: Text('New Alarm',
                          style: Themes.font(
                            25,
                            fontWeight: FontWeight.w800,
                            color: Colors.green,
                          )),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: namaController,
                              decoration: Themes.formStyle('Insert Nama'),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }

                                return null;
                              },
                            ),
                            smallSpace(),
                            Ink(
                              child: InkWell(
                                onTap: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                      hour: DateTime.now().hour,
                                      minute: DateTime.now().minute + 1,
                                    ),
                                  );

                                  if (time == null) {
                                    return;
                                  }

                                  final d = DateTime.now().copyWith(
                                    hour: time.hour,
                                    minute: time.minute,
                                  );

                                  dateTime.value = d;
                                  dateController.text =
                                      DateFormat('HH:mm a').format(d);
                                },
                                child: TextFormField(
                                  enabled: false,
                                  controller: dateController,
                                  keyboardType: TextInputType.streetAddress,
                                  decoration:
                                      Themes.formStyle('Insert DateTime'),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'DateTime tidak boleh kosong';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            TextButton(
                                onPressed: () {
                                  if (formKey.currentState != null) {
                                    if (formKey.currentState!.validate()) {
                                      final id = const Uuid().v1();

                                      final alarm = AlarmModel(
                                        id: id,
                                        nama: namaController.text,
                                        date: dateTime.value,
                                      );

                                      cudSl.add(SaveAlarm(alarm));
                                      notifSl.add(ScheduleNotification(alarm));
                                    }
                                  }
                                },
                                child: Container(
                                  height: 65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.2)),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Insert',
                                      style: Themes.font(
                                        20,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
    );
  }

  _onSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Sukses Create',
          style: Themes.font(
            15,
            color: Colors.white,
          )),
      backgroundColor: Colors.green,
    ));
    alarmSl.add(GetAlarm());
    Navigator.pop(context);
  }

  _onFailure(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed Create : $message',
          style: Themes.font(
            15,
            color: Colors.white,
          )),
      backgroundColor: Colors.red,
    ));
  }
}
