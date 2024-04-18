import 'package:get/route_manager.dart';

import '../presentation/page/home_page.dart';
import '../presentation/page/insert_page.dart';
import '../presentation/page/unknown_page.dart';
import 'routes.dart';

class PageRoutes {
  PageRoutes();

  static GetPage unknownPage() => GetPage(
        name: Routes.unknownPage,
        page: () => const UnknownPage(),
      );

  static List<GetPage> pages() => [
        GetPage(
          name: Routes.homePage,
          page: () => const HomePage(),
        ),
        GetPage(
          name: Routes.insertPage,
          page: () => const InsertPage(),
        ),
      ];
}
