import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/config/themes/app_theme.dart';
import 'package:iGenTech/core/utils/text_direction.dart';

import 'config/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'iGenTech',
          initialRoute: AppRoutes.splashScreenRoute,
          routes: AppRoutes.routes,
          theme: appTheme(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: (context, child) {
            return Directionality(
              textDirection: getTextDirection(context),
              child: child!,
            );
          },
        );
      },
    );
  }
}
