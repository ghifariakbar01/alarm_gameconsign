import 'package:accurative/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/injection.dart';
import '../../style/style.dart';

class FilterBottomWidget extends HookWidget {
  const FilterBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final select = useState(['']);

    final padding = MediaQuery.of(context).padding;
    final bottomPadding = padding.bottom + 50;
    final topPadding = padding.top + 50;

    return userSl.state.maybeWhen(
        data: (val) {
          final List<String> cities =
              val.map((e) => e.city.toLowerCase()).toSet().toList();

          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(bottom: bottomPadding, top: topPadding),
                  child: ListView.builder(
                      itemCount: cities.length,
                      itemBuilder: (context, index) {
                        final String city = cities[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                color: select.value.contains(city)
                                    ? Colors.amber
                                    : Colors.indigo,
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                select.value.contains(city)
                                    ? select.value = select.value
                                        .where((e) => e != city)
                                        .toList()
                                    : select.value = [...select.value, city];
                              },
                              child: Text(
                                city,
                                style: Themes.customColor(12,
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
                        Navigator.pop(context);
                        if (select.value.first.isNotEmpty) {
                          userSl.add(FilterByCity(cities: select.value));
                        }
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
          );
        },
        orElse: () => const Text('Data Loading'));
  }
}
