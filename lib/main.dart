import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'modules/flight/bindings/app_binding.dart';
import 'routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, __) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flight Booking',
          initialBinding: AppBinding(),
          initialRoute: Routes.planTrip,
          getPages: AppPages.pages,
        );
      },
    );
  }
}