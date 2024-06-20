import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/routes.dart';
import '../../data/model/alarm_model.dart';
import '../../style/style.dart';
import 'common_widget.dart';

class AlarmListWidget extends StatelessWidget {
  final List<AlarmModel> data;
  const AlarmListWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              Get.toNamed(
                Routes.detailPage,
                arguments: data[index].id!,
              );
            },
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('HH:mm').format(data[index].date),
                          style: Themes.font(
                            25,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(DateFormat('a').format(data[index].date),
                            style: Themes.font(
                              18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    extraSmallSpace(),
                    Text(
                      data[index].nama,
                      style: Themes.font(12,
                          color: Palette.outlineColor,
                          fontWeight: FontWeight.w800),
                    ),
                    smallSpace(),
                  ],
                ),
                Expanded(child: Container()),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
