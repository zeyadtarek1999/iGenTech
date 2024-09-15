import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/config/routes/app_routes.dart';
import 'package:iGenTech/core/enum/alert_enum.dart';
import 'package:iGenTech/core/services/alert_service.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/core/validations/app_validation.dart';
import 'package:iGenTech/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:iGenTech/features/sign_up/presentation/widgets/already_have_an_account.dart';
import 'package:iGenTech/shared_widgets/form_field_section.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';
import 'package:iGenTech/injection_container.dart';
import 'package:iGenTech/shared_widgets/buttons/custom_elevator_button.dart';
import 'package:iGenTech/shared_widgets/custom_app_bar.dart';
import 'package:iGenTech/shared_widgets/custom_text_form_field.dart';

class SignUpPasswordScreen extends StatelessWidget {
  const SignUpPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSubmitted) {
          final email = context.read<SignUpCubit>().email;

          Navigator.pushReplacementNamed(
            context,
            AppRoutes.profileScreenRoute,
            arguments: email,
          );

          debugPrint('Sign Up Completed!');
        } else if (state is SignUpFormInvalid) {
          debugPrint('Form validation error');
        }
      },
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();

        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: const CustomAppBar(
            title: '',
            showTitle: false,
            showBackButton: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.sign_up.tr(),
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 40.sp,
                        color: AppColors.secTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      LocaleKeys.set_password_prompt.tr(),
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppColors.mainTextColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    FormFieldSection(
                      label: LocaleKeys.set_password.tr(),
                      child: CustomTextFormFieldWidget(
                        fillColor: AppColors.secondColor,
                        hint: LocaleKeys.set_password.tr(),
                        obscureText: !cubit.isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            cubit.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.hintColor,
                          ),
                          onPressed: cubit.togglePasswordVisibility,
                        ),
                        onChange: (value) {
                          cubit.updatePassword(value);
                          formKey.currentState?.validate();
                        },
                        validator: (value) => AppValidator.passwordValidation(value),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    FormFieldSection(
                      label: LocaleKeys.confirm_password.tr(),
                      child: CustomTextFormFieldWidget(
                        fillColor: AppColors.secondColor,
                        hint: LocaleKeys.confirm_password.tr(),
                        obscureText: !cubit.isConfirmPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            cubit.isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.hintColor,
                          ),
                          onPressed: cubit.toggleConfirmPasswordVisibility,
                        ),
                        onChange: (value) {
                          cubit.updateConfirmPassword(value);
                          formKey.currentState?.validate();
                        },
                        validator: (value) => cubit.password == value
                            ? null
                            : LocaleKeys.password_mismatch.tr(),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    CustomElevatedButton(
                      onPressed: () {
                        cubit.submitPasswordForm(formKey);
                      },
                      label: LocaleKeys.register.tr(),
                    ),
                    SizedBox(height: 8.h),
                    const AlreadyHaveAccountRow(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
