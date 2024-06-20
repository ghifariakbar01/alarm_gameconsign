import 'package:alarm/core/injection.dart';
import 'package:alarm/presentation/bloc/alarm/alarm_event.dart';
import 'package:alarm/presentation/bloc/cud_alarm/cud_alarm_event.dart';
import 'package:alarm/presentation/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../style/style.dart';
import '../bloc/alarm/alarm_bloc.dart';
import '../bloc/alarm/alarm_state.dart';
import '../bloc/cud_alarm/cud_alarm_bloc.dart';
import '../bloc/cud_alarm/cud_alarm_state.dart';
import '../widget/list_loading_widget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.id});

  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    alarmSl.add(GetAlarmById(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        alarmSl.add(GetAlarm());
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.black,
          title: Text('Alarm Detail',
              style: Themes.font(
                25,
                fontWeight: FontWeight.w800,
                color: Colors.green,
              )),
        ),
        body: BlocConsumer<CudAlarmBloc, CudAlarmState>(
          bloc: cudSl,
          listener: (_, state) {
            state.maybeWhen(
              orElse: () {},
              success: () => _onSuccess(context),
            );
          },
          builder: (_, state) => BlocBuilder<AlarmBloc, AlarmState>(
              builder: (context, stateAlarm) => stateAlarm.map(
                  data: (value) {
                    final data = value.data;
                    if (data.isEmpty) return Container();
                    final alarm = data.first;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ID : ${alarm.id.toString()}',
                            style: Themes.font(
                              15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                        smallSpace(),
                        Text(
                          DateFormat('HH:mm a').format(alarm.date),
                          style: Themes.font(
                            30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        smallSpace(),
                        const Center(
                          child: Icon(
                            Icons.alarm,
                            size: 200,
                            color: Colors.white,
                          ),
                        ),
                        smallSpace(),
                        Text(
                          alarm.nama,
                          style: Themes.font(
                            20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        smallSpace(),
                        TextButton(
                            onPressed: () {
                              cudSl.add(DeleteAlarm(alarm));
                            },
                            child: Text('Delete Alarm',
                                style: Themes.font(
                                  15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ))),
                      ],
                    );
                  },
                  loading: (_) => const ListLoadingWidget(),
                  failure: (value) => ErrorWidget(value.failure.message))),
        ),
      ),
    );
  }

  _onSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Sukses Delete',
          style: Themes.font(
            15,
            color: Colors.white,
          )),
      backgroundColor: Colors.green,
    ));
    alarmSl.add(GetAlarm());
    Navigator.pop(context);
  }
}
