
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'modules/flight/services/api_client.dart';

import 'modules/flight/bindings/app_binding.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize ApiClient early
  await ApiClient.instance.init(
    baseUrl: 'https://flight.wigian.in',
    timeout: const Duration(seconds: 60),
    logging: true,
  );
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
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          title: 'Flight Booking',
          initialBinding: AppBinding(),
          initialRoute: Routes.planTrip,
          getPages: AppPages.pages,
        );
      },
    );
  }
}