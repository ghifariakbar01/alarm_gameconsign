import 'package:flutter/material.dart';

import '../presentation/page/home_page.dart';
import 'routes.dart';

class PageRoutes {
  PageRoutes();
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (_) => _getPageRoute(routeSettings),
    );
  }

  Widget _getPageRoute(RouteSettings routeSettings) {
    try {
      switch (routeSettings.name) {
        case Routes.homePage:
          return const HomePage();
        default:
          return _UnderMaintanancePage(
              message: 'No route defined for ${routeSettings.name}');
      }
    } on Error catch (e) {
      return _UnderMaintanancePage(message: e);
    } catch (e) {
      return _UnderMaintanancePage(message: e);
    }
  }
}

class _UnderMaintanancePage extends StatelessWidget {
  final dynamic message;
  const _UnderMaintanancePage({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Page tidak dapat ditemukan : $message"));
  }
}
