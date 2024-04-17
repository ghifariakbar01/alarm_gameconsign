import 'package:accurative/presentation/widget/filter_bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../core/injection.dart';

import '../../style/style.dart';
import '../bloc/user_bloc.dart';

import '../bloc/user_state.dart';
import '../widget/list_loading_widget.dart';
import '../widget/user_list_widget.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final isSearching = useState(false);
    final isSorted = useState(false);

    return KeyboardDismissOnTap(
      child: BlocProvider(
        create: (_) => userSl..add(GetUser()),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 81,
            title: TextFormField(
              controller: controller,
              onTap: () => isSearching.value = true,
              onTapOutside: (_) => isSearching.value = false,
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  userSl.add(SearchByName(value));
                } else {
                  userSl.add(GetUser());
                  isSearching.value = false;
                }
              },
              decoration: Themes.formStyle('Search User'),
            ),
            actions: isSearching.value
                ? []
                : [
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => const FilterBottomWidget(),
                          );
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
            leadingWidth: isSearching.value ? double.infinity : 100,
            backgroundColor: Colors.amber,
          ),
          body: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) => state.map(
                  data: (value) {
                    final data = value.user;
                    if (data.isEmpty) return Container();
                    return SafeArea(
                      child: UserListWidget(
                        data: data,
                      ),
                    );
                  },
                  loading: (_) => const ListLoadingWidget(),
                  failure: (value) => ErrorWidget(value))),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
