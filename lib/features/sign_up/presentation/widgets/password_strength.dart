import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String? password;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        if (state is SignUpFormUpdated) {
          String passwordStrength = LocaleKeys.password_strength_fair.tr();
          Color strengthColor = Colors.red;
          IconData strengthIcon = Icons.cancel;

          if (state.hasMinLength && state.hasSymbolOrNumber && state.hasNoSpaces && state.hasNoNameOrEmail) {
            passwordStrength = LocaleKeys.password_strength_excellent.tr();
            strengthColor = AppColors.mainColor;
            strengthIcon = Icons.check_circle;
          } else if (state.hasMinLength && state.hasSymbolOrNumber) {
            passwordStrength = LocaleKeys.password_strength_good.tr();
            strengthColor = Colors.orange;
            strengthIcon = Icons.check_circle;
          } else if (state.hasMinLength) {
            passwordStrength = LocaleKeys.password_strength_fair.tr();
            strengthColor = AppColors.mainColor;
            strengthIcon = Icons.check_circle;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    strengthIcon,
                    color: strengthColor,
                    size: 24.w,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "${LocaleKeys.password_strength.tr()}: $passwordStrength",
                    style: TextStyle(
                      color: strengthColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              _buildPasswordCriteriaItem(
                context,
                state.hasMinLength,
                LocaleKeys.password_min_length.tr(),
              ),
              _buildPasswordCriteriaItem(
                context,
                state.hasSymbolOrNumber,
                LocaleKeys.password_symbol_or_number.tr(),
              ),
              _buildPasswordCriteriaItem(
                context,
                state.hasNoSpaces,
                LocaleKeys.password_no_spaces.tr(),
              ),
              _buildPasswordCriteriaItem(
                context,
                state.hasNoNameOrEmail,
                LocaleKeys.password_no_name_or_email.tr(),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildPasswordCriteriaItem(BuildContext context, bool isValid, String criteria) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? AppColors.mainColor : AppColors.secondColor,
          size: 18.w,
        ),
        SizedBox(width: 8.w),
        Text(
          criteria,
          style: TextStyle(
            color: isValid ? AppColors.mainColor : AppColors.secondColor,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
