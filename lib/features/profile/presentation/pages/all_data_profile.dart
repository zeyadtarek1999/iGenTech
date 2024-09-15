import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/features/profile/presentation/widgets/profile_form.dart';
import 'package:iGenTech/shared_widgets/custom_app_bar.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/features/profile/presentation/manager/profile_cubit.dart';

class UserProfileScreen extends StatelessWidget {

  const UserProfileScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const CustomAppBar(
        title: '',
        showTitle: false,
        showBackButton: true,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return const ProfileForm();
          } else if (state is ProfileError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}
