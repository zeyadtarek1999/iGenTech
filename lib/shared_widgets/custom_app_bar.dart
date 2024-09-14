import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/shared_widgets/language_switch_button.dart';
import 'package:iGenTech/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final bool showTitle;

  const CustomAppBar({
    super.key,
     this.title,
    this.showBackButton = true,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(surfaceTintColor: AppColors.bgColor,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.bgColor,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
          : null,
      title: showTitle
          ? Text(
        title ?? '',
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(
          fontWeight: FontWeight.w800,
          color: AppColors.secTextColor,
        ),
      )
          : null,
      actions:  [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h,horizontal: 8.0.w),
          child: const LanguageSwitchButton(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
