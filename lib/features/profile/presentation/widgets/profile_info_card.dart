import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/config/routes/app_routes.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/features/profile/presentation/manager/profile_cubit.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.userProfileScreenRoute);
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.profile.fullName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: AppColors.secTextColor,
                                fontWeight: FontWeight.w800,
                              ),
                          overflow: TextOverflow.visible,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          state.profile.email,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.normal,
                              ),
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ProfileError) {
          return Text("Error: ${state.message}");
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
