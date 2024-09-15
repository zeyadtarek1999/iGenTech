import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/features/profile/presentation/manager/profile_cubit.dart';
import 'package:iGenTech/features/profile/presentation/widgets/menu_items_section.dart';
import 'package:iGenTech/features/profile/presentation/widgets/profile_info_card.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';
import 'package:iGenTech/shared_widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String;
    if (email.isNotEmpty) {
      debugPrint('email is $email');
      context.read<ProfileCubit>().loadProfile(email);
    }

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const CustomAppBar(showTitle: false, showBackButton: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.profile.tr(),
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 40.sp,
                color: AppColors.secTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20.h),
            const ProfileInfoCard(),
            SizedBox(height: 20.h),
            const MenuItemsSection(),
          ],
        ),
      ),
    );
  }
}
