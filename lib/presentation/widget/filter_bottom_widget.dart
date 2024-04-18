import 'package:accurative/presentation/cubit/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/injection.dart';
import '../../style/style.dart';
import '../bloc/user/user_bloc.dart';

class FilterBottomWidget extends HookWidget {
  const FilterBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    final bottomPadding = padding.bottom + 50;
    final topPadding = padding.top + 50;

    return userSl.state.maybeWhen(
      orElse: () => const Text('Data Loading'),
      data: (val) {
        final List<String> cities =
            val.map((e) => e.city.toLowerCase()).toSet().toList();

        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return SafeArea(
              child: BlocBuilder<FilterCubit, List<String>>(
                builder: (context, state) => Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: bottomPadding, top: topPadding),
                      child: ListView.builder(
                          itemCount: cities.length,
                          itemBuilder: (context, index) {
                            final String city = cities[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    color: filterSl.state.contains(city)
                                        ? Colors.amber
                                        : Colors.indigo,
                                    borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.all(8),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      filterSl.state.contains(city)
                                          ? filterSl.removeCity(city)
                                          : filterSl.addCity(city);
                                    });
                                  },
                                  child: Text(
                                    city,
                                    style: Themes.font(12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: TextButton(
                          onPressed: () {
                            if (state.isNotEmpty) {
                              userSl.add(FilterByCity(cities: state));
                            }

                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.all(8),
                                child: const Center(child: Text('OK'))),
                          )),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
