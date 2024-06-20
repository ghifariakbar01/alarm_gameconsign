import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../style/style.dart';

class HomeAppBarWidget extends HookWidget implements PreferredSizeWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.black,
      title: Text('Alarm',
          style: Themes.font(
            25,
            fontWeight: FontWeight.w800,
            color: Colors.green,
          )),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 80);
}
