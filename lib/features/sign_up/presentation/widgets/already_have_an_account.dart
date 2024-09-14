import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iGenTech/config/routes/app_routes.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';

class AlreadyHaveAccountRow extends StatelessWidget {
  const AlreadyHaveAccountRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.already_have_account.tr(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.secTextColor,
            fontWeight: FontWeight.normal,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.signInScreenRoute);
          },
          child: Text(
            LocaleKeys.login.tr(),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.mainTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
