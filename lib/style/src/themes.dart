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
    return IconThemeData(color: color ?? Colors.white);
  }

  static OutlineInputBorder notFocused() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Palette.outlineColor));
  }

  static OutlineInputBorder focused() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.green));
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
      focusedBorder: Themes.focused(),
      enabledBorder: Themes.notFocused(),
      errorBorder: Themes.error(),
      contentPadding: const EdgeInsets.all(16),
      hintStyle: Themes.font(
        18,
        color: textColor ?? Colors.white,
        fontWeight: FontWeight.normal,
      ),
      labelStyle: Themes.font(
        18,
        color: textColor ?? Colors.white,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.black,
      secondaryHeaderColor: Colors.white,
      unselectedWidgetColor: Colors.white,
      cardColor: Colors.white.withOpacity(0.05),
      disabledColor: Colors.white.withOpacity(0.15),
    );
  }
}
