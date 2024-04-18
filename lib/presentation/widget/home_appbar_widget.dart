import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/route_manager.dart';

import '../../core/injection.dart';
import '../../style/style.dart';
import '../bloc/user/user_bloc.dart';
import 'filter/filter_bottom_widget.dart';

class HomeAppBarWidget extends HookWidget implements PreferredSizeWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final isSearching = useState(false);
    final isSorted = useState(false);

    return AppBar(
      toolbarHeight: 80,
      leadingWidth: isSearching.value ? double.infinity : 100,
      backgroundColor: Palette.secondaryColor,
      title: TextFormField(
        controller: controller,
        onTap: () {
          userSl.add(GetUser());
          isSearching.value = true;
        },
        onTapOutside: (_) => isSearching.value = false,
        onFieldSubmitted: (value) {
          if (value.isNotEmpty) {
            userSl.add(SearchByName(value));
          } else {
            userSl.add(GetUser());
            isSearching.value = false;
          }
        },
        style: Themes.font(14, color: Colors.white),
        decoration: Themes.formStyle('Search User', textColor: Colors.white),
      ),
      actions: isSearching.value
          ? []
          : [
              IconButton(
                  onPressed: () {
                    userSl.add(GetUser());
                    Get.bottomSheet(
                        isScrollControlled: true, const FilterBottomWidget());
                  },
                  icon: const Icon(Icons.sort)),
              IconButton(
                  onPressed: () {
                    isSorted.value
                        ? isSorted.value = false
                        : isSorted.value = true;
                    userSl.add(SortByName(isReverse: isSorted.value));
                  },
                  icon: isSorted.value
                      ? const Icon(Icons.south_rounded)
                      : const Icon(Icons.north_rounded))
            ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 80);
}
