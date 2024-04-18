part of '../style.dart';

mixin Themes {
  static TextStyle font(
    double fontSize, {
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      decoration: decoration,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  static OutlineInputBorder notFocused({Color? color}) {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: color ?? Palette.grey));
  }

  static OutlineInputBorder focused({Color? color}) {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: color ?? Palette.primaryColor));
  }

  static InputDecoration formStyle(String hintText, {Widget? icon}) {
    return InputDecoration(
      hintText: hintText,
      suffixIcon: icon,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: Themes.notFocused(),
      contentPadding: const EdgeInsets.all(16),
      hintStyle: Themes.font(
        14,
        fontWeight: FontWeight.normal,
      ),
      labelStyle: Themes.font(
        14,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
