import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/font_details.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.mainColor,
    hintColor: AppColors.hintColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: FontDetails.fontFamilyName,
    textTheme: TextTheme(
      // Display texts
      displayLarge: TextStyle(
        fontWeight: FontDetails.boldFontWeight,
        color: AppColors.mainColor,
        fontSize: FontDetails.fontSizeXL,
      ),
      displayMedium: TextStyle(
        fontWeight: FontDetails.mediumFontWeight,
        color: AppColors.mainColor,
        fontSize: FontDetails.fontSizeM,
      ),
      displaySmall: TextStyle(
        fontWeight: FontDetails.mediumFontWeight,
        color: AppColors.mainColor,
        fontSize: FontDetails.fontSizeS,
      ),

      // Headlines
      headlineLarge: TextStyle(
        fontWeight: FontDetails.boldFontWeight,
        color: AppColors.white,
        fontSize: FontDetails.fontSizeL,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontDetails.mediumFontWeight,
        color: AppColors.white,
        fontSize: FontDetails.fontSizeM,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontDetails.regularFontWeight,
        color: AppColors.white,
        fontSize: FontDetails.fontSizeXS,
      ),

      // Titles
      titleSmall: TextStyle(
        fontWeight: FontDetails.mediumFontWeight,
        color: AppColors.black,
        fontSize: FontDetails.fontSizeXS,
      ),
      titleMedium: TextStyle(
        fontWeight: FontDetails.semiBoldFontWeight,
        color: AppColors.black,
        fontSize: FontDetails.fontSizeM,
      ),
      titleLarge: TextStyle(
        fontWeight: FontDetails.semiBoldFontWeight,
        color: AppColors.black,
        fontSize: FontDetails.fontSizeL,
      ),

      // Body texts
      bodySmall: TextStyle(
        fontWeight: FontDetails.mediumFontWeight,
        color: AppColors.mainTextColor,
        fontSize: FontDetails.fontSizeXS,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontDetails.mediumFontWeight,
        color: AppColors.mainTextColor,
        fontSize: FontDetails.fontSizeM,
      ),
      bodyLarge: TextStyle(
        fontWeight: FontDetails.mediumFontWeight,
        color: AppColors.mainTextColor,
        fontSize: FontDetails.fontSizeL,
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.mainColor),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.r),
        )),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        ),
        minimumSize: WidgetStateProperty.all(Size(150.w, 50.h)),
        textStyle: WidgetStateProperty.resolveWith(
              (states) => TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            fontSize: FontDetails.fontSizeM,
            color: AppColors.white,
          ),
        ),
      ),
    ),

    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.mainColor),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        )),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
        textStyle: WidgetStateProperty.resolveWith(
              (states) => TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            fontSize: FontDetails.fontSizeM,
            color: AppColors.white,
          ),
        ),
      ),
    ),

    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.r),
        )),
        textStyle: WidgetStateProperty.resolveWith(
              (states) => TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            fontSize: FontDetails.fontSizeM,
            color: AppColors.mainColor,
          ),
        ),
      ),
    ),

    dialogTheme: DialogTheme(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
    ),
  );
}
