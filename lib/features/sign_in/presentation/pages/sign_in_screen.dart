import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/config/routes/app_routes.dart';
import 'package:iGenTech/core/enum/alert_enum.dart';
import 'package:iGenTech/core/services/alert_service.dart';
import 'package:iGenTech/features/sign_in/presentation/manager/sign_in_cubit.dart';
import 'package:iGenTech/features/sign_in/presentation/widgets/dont_have_account_widget.dart';
import 'package:iGenTech/injection_container.dart';
import 'package:iGenTech/shared_widgets/buttons/custom_elevator_button.dart';
import 'package:iGenTech/shared_widgets/custom_app_bar.dart';
import 'package:iGenTech/shared_widgets/custom_text_form_field.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/core/validations/app_validation.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:iGenTech/shared_widgets/form_field_section.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const CustomAppBar(
        showTitle: false,
        showBackButton: false,
      ),
      body: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            final email = context.read<SignInCubit>().email;
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.profileScreenRoute,
              arguments: email,
            );            getIt<AlertService>().showAlert(
              context: context,
              title: LocaleKeys.success.tr(),
              subtitle: LocaleKeys.login_successful.tr(),
              status: AlertStatus.success,
            );
          } else if (state is SignInFailure) {
            getIt<AlertService>().showAlert(
              context: context,
              title: LocaleKeys.error.tr(),
              subtitle: LocaleKeys.login_error.tr(),
              status: AlertStatus.error,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignInCubit>();

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.sign_in.tr(),
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 40.sp,
                                color: AppColors.secTextColor,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      LocaleKeys.enter_credentials.tr(),
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColors.mainTextColor,
                                fontWeight: FontWeight.normal,
                              ),
                    ),
                    SizedBox(height: 30.h),
                    FormFieldSection(
                      label: LocaleKeys.email.tr(),
                      child: CustomTextFormFieldWidget(
                        fillColor: Colors.white,
                        hint: LocaleKeys.email.tr(),
                        textInputType: TextInputType.emailAddress,
                        validator: (value) =>
                            AppValidator.emailValidation(value),
                        onChange: (value) => cubit.updateEmail(value),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    FormFieldSection(
                      label: LocaleKeys.password.tr(),
                      child: CustomTextFormFieldWidget(
                        fillColor: Colors.white,
                        hint: LocaleKeys.password.tr(),
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
                        onChange: (value) => cubit.updatePassword(value),
                        validator: (value) =>
                            AppValidator.passwordValidation(value),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          LocaleKeys.forgot_password.tr(),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.mainColor,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    if (state is SignInLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      CustomElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            cubit.signIn();
                          }
                        },
                        label: LocaleKeys.log_in.tr(),
                      ),
                    SizedBox(height: 20.h),
                    const DontHaveAccountWidget()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
