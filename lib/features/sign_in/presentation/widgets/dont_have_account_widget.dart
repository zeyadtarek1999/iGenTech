import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/config/routes/app_routes.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';

class DontHaveAccountWidget extends StatelessWidget {

  const DontHaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.dont_have_account.tr(),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.secTextColor,
              fontSize: 14.sp,
            ),
          ),
          TextButton(
            onPressed: (){Navigator.pushNamed(context, AppRoutes.signUpScreenRoute);},
            child: Text(
              LocaleKeys.sign_up.tr(),
              style: TextStyle(
                color: AppColors.mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
