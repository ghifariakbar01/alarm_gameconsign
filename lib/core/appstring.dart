import 'package:get_it/get_it.dart';

class AppString {
  String get baseUrl =>
      "https://627e360ab75a25d3f3b37d5a.mockapi.io/api/v1/accurate";
  static String get endPointUrl => GetIt.instance<AppString>().baseUrl;
}
