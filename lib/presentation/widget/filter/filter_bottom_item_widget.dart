import 'package:flutter/material.dart';

import '../../../style/style.dart';

class FilterBottomItemWidget extends StatelessWidget {
  const FilterBottomItemWidget({
    super.key,
    required this.city,
    required this.onTap,
    required this.isSelected,
  });

  final String city;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Ink(
        decoration: BoxDecoration(
            color: isSelected ? Palette.secondaryColor : Colors.transparent,
            border: Border.all(
                color: isSelected ? Colors.transparent : Palette.outlineColor),
            borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(8),
        height: 75,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              city,
              style: Themes.font(12,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}
