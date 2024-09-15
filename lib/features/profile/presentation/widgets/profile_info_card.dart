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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.profile.fullName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        state.profile.email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: AppColors.secondColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.userProfileScreenRoute);
                    },
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
