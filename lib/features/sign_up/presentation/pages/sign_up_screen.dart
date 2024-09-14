import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:iGenTech/features/sign_up/presentation/pages/sign_up_password_screen.dart';
import 'package:iGenTech/shared_widgets/custom_text_form_field.dart';
import 'package:iGenTech/shared_widgets/custom_app_bar.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const CustomAppBar(
        showTitle: true,
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
                'Create an account to continue!',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.mainTextColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: 20.h),
              // Full Name
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return CustomTextFormFieldWidget(
                    hint: 'Full Name',
                    onChange: (value) =>
                        context.read<SignUpCubit>().updateFullName(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  );
                },
              ),
              SizedBox(height: 16.h),
              // Email
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return CustomTextFormFieldWidget(
                    hint: 'Email',
                    textInputType: TextInputType.emailAddress,
                    onChange: (value) =>
                        context.read<SignUpCubit>().updateEmail(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  );
                },
              ),
              SizedBox(height: 16.h),
              // Gender Dropdown
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return DropdownButtonFormField<String>(
                    hint: const Text('Gender'),
                    items: ['Male', 'Female']
                        .map((gender) => DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        context.read<SignUpCubit>().updateGender(value!),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.secondColor,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 14.h),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.mainColor, width: 1.w),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
              // Birth Date Picker
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  return CustomTextFormFieldWidget(
                    hint: 'Birth of date',
                    readOnly: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        // Show date picker logic
                      },
                    ),
                    onChange: (value) =>
                        context.read<SignUpCubit>().updateBirthDate(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Birth date is required';
                      }
                      return null;
                    },
                  );
                },
              ),
              SizedBox(height: 30.h),
              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Proceed to next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPasswordScreen(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.mainColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                    ),
                  ),
                  child: Text(
                    'Continue',
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
  }
}
