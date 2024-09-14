import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/core/validations/app_validation.dart';
import 'package:iGenTech/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:iGenTech/features/sign_up/presentation/widgets/password_requirement_widget.dart';
import 'package:iGenTech/shared_widgets/custom_app_bar.dart';
import 'package:iGenTech/shared_widgets/custom_text_form_field.dart';

class SignUpPasswordScreen extends StatelessWidget {
  const SignUpPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: const CustomAppBar(
            title: 'Sign up',
            showBackButton: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    'Set a password to complete registration!',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.mainTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Password
                  CustomTextFormFieldWidget(
                    hint: 'Set Password',
                    obscureText: true,
                    onChange: (value) => context.read<SignUpCubit>().updatePassword(value),
                    validator: (value) => AppValidator.passwordValidation(value),
                  ),
                  SizedBox(height: 20.h),
                  // Confirm Password
                  CustomTextFormFieldWidget(
                    hint: 'Confirm Password',
                    obscureText: true,
                    onChange: (value) => context.read<SignUpCubit>().updateConfirmPassword(value),
                    validator: (value) => context.read<SignUpCubit>().confirmPasswordValidation(value),
                  ),
                  SizedBox(height: 20.h),
                  // Password strength indicators
                  if (state is SignUpFormUpdated)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              state.passwordStrength == 'excellent'
                                  ? Icons.check_circle
                                  : Icons.info,
                              color: state.passwordStrength == 'excellent'
                                  ? AppColors.mainColor
                                  : AppColors.error,
                              size: 18.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Password strength: ${state.passwordStrength}',
                              style: TextStyle(
                                color: AppColors.mainTextColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        PasswordRequirementWidget(
                          requirement: 'Must be at least 8 characters',
                          fulfilled: state.hasMinLength,
                        ),
                        PasswordRequirementWidget(
                          requirement: 'Can’t include your name or email address',
                          fulfilled: state.hasNoNameOrEmail,
                        ),
                        PasswordRequirementWidget(
                          requirement: 'Must have at least one symbol or number',
                          fulfilled: state.hasSymbolOrNumber,
                        ),
                        PasswordRequirementWidget(
                          requirement: 'Can’t contain spaces',
                          fulfilled: state.hasNoSpaces,
                        ),
                      ],
                    ),
                  SizedBox(height: 30.h),
                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<SignUpCubit>().submitForm();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AppColors.mainColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.r),
                          ),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
