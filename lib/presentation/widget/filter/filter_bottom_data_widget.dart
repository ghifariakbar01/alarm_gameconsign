import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../core/injection.dart';
import '../../../style/style.dart';
import '../../bloc/user/user_bloc.dart';
import '../../cubit/filter_cubit.dart';
import 'filter_bottom_item_widget.dart';

class FilterBottomDataWidget extends StatelessWidget {
  const FilterBottomDataWidget({
    super.key,
    required this.cities,
  });

  final List<String> cities;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    final bottomPadding = padding.bottom + 50;
    final topPadding = padding.top + 50;

    return StatefulBuilder(builder: (_, setState) {
      return BlocBuilder<FilterCubit, List<String>>(
        bloc: filterSl,
        builder: (context, state) => Stack(
          children: [
            Padding(
                padding:
                    EdgeInsets.only(bottom: bottomPadding, top: topPadding),
                child: ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];

                      return FilterBottomItemWidget(
                        city: city,
                        isSelected: state.contains(city),
                        onTap: () => setState(() {
                          state.contains(city)
                              ? filterSl.removeCity(city)
                              : filterSl.addCity(city);
                        }),
                      );
                    })),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: TextButton(
                  onPressed: () {
                    if (state.isNotEmpty) {
                      userSl.add(FilterByCity(cities: state));
                    }
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            'OK',
                            style: Themes.font(15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  )),
            ),
          ],
        ),
      );
    });
  }
}
