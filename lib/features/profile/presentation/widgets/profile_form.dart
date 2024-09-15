import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart'; // Import Easy Localization
import 'package:iGenTech/config/routes/app_routes.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';
import 'package:iGenTech/shared_widgets/buttons/custom_elevator_button.dart';
import 'package:iGenTech/shared_widgets/custom_text_form_field.dart';
import 'package:iGenTech/shared_widgets/form_field_section.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/features/profile/presentation/manager/profile_cubit.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cubit.fullNameController.text,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  cubit.emailController.text,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.greenAccent,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 20.h),

                // Full Name Section
                FormFieldSection(
                  label: LocaleKeys.full_name.tr(),
                  child: CustomTextFormFieldWidget(
                    fillColor: AppColors.secondColor,
                    controller: cubit.fullNameController,
                    hint: LocaleKeys.full_name.tr(),
                    readOnly: true,
                    validator: (value) => null,
                  ),
                ),
                SizedBox(height: 20.h),

                // Email Section
                FormFieldSection(
                  label: LocaleKeys.email.tr(),
                  child: CustomTextFormFieldWidget(
                    fillColor: AppColors.secondColor,
                    controller: cubit.emailController,
                    hint: LocaleKeys.email.tr(),
                    readOnly: true,
                    validator: (value) => null,
                  ),
                ),
                SizedBox(height: 20.h),

                // Gender Section
                FormFieldSection(
                  label: LocaleKeys.gender.tr(),
                  child: CustomTextFormFieldWidget(
                    fillColor: AppColors.secondColor,
                    controller: cubit.genderController,
                    hint: LocaleKeys.gender.tr(),
                    readOnly: true,
                    validator: (value) => null,
                  ),
                ),
                SizedBox(height: 20.h),

                // Birth Date Section
                FormFieldSection(
                  label: LocaleKeys.birth_date.tr(),
                  child: CustomTextFormFieldWidget(
                    fillColor: AppColors.secondColor,
                    controller: cubit.birthDateController,
                    hint: LocaleKeys.birth_date.tr(),
                    readOnly: true,
                    validator: (value) => null,
                  ),
                ),
                SizedBox(height: 20.h),

                // Location Section
                FormFieldSection(
                  label: LocaleKeys.location.tr(),
                  child: GestureDetector(
                    onTap: () => context.read<ProfileCubit>().openMap(),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 12.h),
                      decoration: BoxDecoration(
                        color: AppColors.secondColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        LocaleKeys.view_in_map.tr(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),

                Center(
                  child: CustomElevatedButton(
                    label: LocaleKeys.log_out.tr(),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.signInScreenRoute);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
