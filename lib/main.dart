import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'app/modules/home/controllers/control.dart';

import 'package:login/app/modules/home/bindlings/home_bindling.dart';

import 'Page/home.dart';

void main() {
  // method utama
  runApp(
    // berfungsi untuk menjalankan aplikasi
    GetMaterialApp(
      title: "Application",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
        ).copyWith(
          secondary: const Color.fromARGB(255, 253, 174, 5),
        ),
      ),
      initialRoute: AppPages.initial,
      getPages: [
        ...AppPages.routes,
        GetPage<dynamic>(name: "/Page/home", page: () => mainhome()),
      ],
      debugShowCheckedModeBanner: false,
    ),
  );
}

class AppPages extends StatelessWidget {
  const AppPages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  static const initial = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => mainhome(),
      binding: HomeBinding(),
    ),
  ];
}

// Route path
abstract class Routes {
  static const HOME = _Paths.HOME;
}

abstract class _Paths {
  // ignore: constant_identifier_names
  static const HOME = '/home';
}
