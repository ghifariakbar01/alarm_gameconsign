part of '../style.dart';

mixin Themes {
  static TextStyle font(
    double fontSize, {
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: fontSize,
      decoration: decoration,
      color: color ?? Colors.black,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  static IconThemeData iconColor({Color? color}) {
    return IconThemeData(color: color ?? Colors.black);
  }

  static OutlineInputBorder notFocused() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Palette.outlineColor));
  }

  static OutlineInputBorder focused() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Palette.primaryColor));
  }

  static OutlineInputBorder error() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Palette.errorColor));
  }

  static InputDecoration formStyle(String hintText,
      {Widget? icon, Color? textColor}) {
    return InputDecoration(
      hintText: hintText,
      suffixIcon: icon,
      border: InputBorder.none,
      focusedBorder: Themes.focused(),
      enabledBorder: Themes.notFocused(),
      errorBorder: Themes.error(),
      contentPadding: const EdgeInsets.all(16),
      hintStyle: Themes.font(
        14,
        color: textColor ?? Colors.black,
        fontWeight: FontWeight.normal,
      ),
      labelStyle: Themes.font(
        14,
        color: textColor ?? Colors.black,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
