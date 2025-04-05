import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'futures/auth/controllers/user_controller.dart';
import 'routes/app_routes.dart';
import 'routes/routes.dart';
import 'routes/routes_observers.dart';
import 'utils/constants/text_strings.dart';
import 'utils/device/web_material_scroll.dart';
import 'utils/helpers/network_manager.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [
        RouteObservers(),
      ],
      title: HTexts.appName,
      themeMode: ThemeMode.light,
      theme: HAppTheme.lightTheme,
      darkTheme: HAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      initialBinding: BindingsBuilder(
        () {
          Get.lazyPut(() => NetworkManager(), fenix: true);
          Get.put(UserController(), permanent: true);
        },
      ),
      getPages: HAppRoutes.pages,
      initialRoute: HRoutes.dashboard,
      unknownRoute: GetPage(
          name: "/page-not-found",
          page: () =>
              const Scaffold(body: Center(child: Text("Page Not Found")))),
    );
  }
}
