import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/generated/assets.gen.dart';

class LanguageSwitchButton extends StatelessWidget {
  const LanguageSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Locale currentLocale = context.locale;

        if (currentLocale.languageCode == 'ar') {
          await context.setLocale(const Locale('en'));
        } else {
          await context.setLocale(const Locale('ar'));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.0.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: AppColors.secondColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.icons.language,
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(width: 8.w),
            Text(
              context.locale.languageCode == 'ar' ? 'En' : 'Ar',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
