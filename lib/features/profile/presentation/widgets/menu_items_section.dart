import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:iGenTech/config/routes/app_routes.dart';
import 'package:iGenTech/core/services/pop_up.dart';
import 'package:iGenTech/features/profile/presentation/widgets/custom_bottom_sheet.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';
import 'menu_item.dart';

class MenuItemsSection extends StatelessWidget {
  const MenuItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuItem(
          icon: Icons.person,
          title: LocaleKeys.my_account.tr(),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.userProfileScreenRoute);
          },
        ),
        MenuItem(
          icon: Icons.logout,
          title: LocaleKeys.log_out.tr(),
          onTap: () {
            Navigator.pushReplacementNamed(context, AppRoutes.signInScreenRoute);
          },
        ),
        SizedBox(height: 20.h),
        MenuItem(
          icon: Icons.code,
          title: LocaleKeys.code_design.tr(),
          onTap: () {

            showCustomBottomSheet(context);
          },
        ),
        MenuItem(
          icon: Icons.favorite,
          title: LocaleKeys.special_thanks.tr(),
          onTap: () {
            PopUp.showPopup(
                context,
                LocaleKeys.special_thanks.tr(),
                LocaleKeys.specialThanks.tr()
            );
          },
        ),
      ],
    );
  }
}
