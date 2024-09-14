import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iGenTech/config/routes/app_routes.dart';
import 'package:iGenTech/core/enum/alert_enum.dart';
import 'package:iGenTech/core/services/alert_service.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:iGenTech/features/sign_up/presentation/widgets/already_have_an_account.dart';
import 'package:iGenTech/shared_widgets/form_field_section.dart';
import 'package:iGenTech/generated/assets.gen.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';
import 'package:iGenTech/injection_container.dart';
import 'package:iGenTech/shared_widgets/buttons/custom_elevator_button.dart';
import 'package:iGenTech/shared_widgets/custom_date_picker.dart';
import 'package:iGenTech/shared_widgets/custom_drop_down/custom_drop_down.dart';
import 'package:iGenTech/shared_widgets/custom_text_form_field.dart';
import 'package:iGenTech/shared_widgets/custom_app_bar.dart';
import 'package:iGenTech/shared_widgets/custom_drop_down/cubit/custom_drop_down_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const CustomAppBar(
        showTitle: false,
        showBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSubmitted) {
              Navigator.pushNamed(context, AppRoutes.signUpPasswordScreenRoute);
            } else if (state is SignUpFormInvalid) {
              getIt<AlertService>().showAlert(
                context: context,
                title: LocaleKeys.error.tr(),
                subtitle: LocaleKeys.please_fill_all_fields.tr(),
                status: AlertStatus.error,
              );
            } else if (state is SignUpEmailAlreadyRegistered) {
              getIt<AlertService>().showAlert(
                context: context,
                title: LocaleKeys.error.tr(),
                subtitle: LocaleKeys.email_already_registered.tr(),
                status: AlertStatus.error,
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<SignUpCubit>();

            return SingleChildScrollView(
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
                    LocaleKeys.create_account.tr(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: AppColors.mainTextColor,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  SizedBox(height: 20.h),
                  FormFieldSection(
                    label: LocaleKeys.full_name.tr(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormFieldWidget(
                          fillColor: AppColors.secondColor,
                          hint: LocaleKeys.full_name.tr(),
                          onChange: (value) => cubit.updateFullName(value),
                          validator: (_) => (state is SignUpFormInvalid &&
                                  state.nameError != null)
                              ? state.nameError
                              : null,
                        ),
                        if (state is SignUpFormInvalid &&
                            state.nameError != null)
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              state.nameError!,
                              style: TextStyle(color: AppColors.error),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  FormFieldSection(
                    label: LocaleKeys.email.tr(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormFieldWidget(
                          hint: LocaleKeys.email.tr(),
                          fillColor: AppColors.secondColor,
                          textInputType: TextInputType.emailAddress,
                          onChange: (value) => cubit.updateEmail(value),
                          validator: (_) => (state is SignUpFormInvalid &&
                                  state.emailError != null)
                              ? state.emailError
                              : null,
                        ),
                        if (state is SignUpFormInvalid &&
                            state.emailError != null)
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              state.emailError!,
                              style: TextStyle(color: AppColors.error),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  FormFieldSection(
                    label: LocaleKeys.select_gender.tr(),
                    child: BlocProvider(
                      create: (context) => DropdownCubit<String>(),
                      child: CustomRadioDropdown<String>(
                        hintText: LocaleKeys.select_gender.tr(),
                        items: [LocaleKeys.males.tr(), LocaleKeys.females.tr()],
                        onItemSelected: (value) {
                          cubit.updateGender(value);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  FormFieldSection(
                    label: LocaleKeys.birth_date.tr(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormFieldWidget(
                          controller: cubit.birthDateController,
                          fillColor: AppColors.secondColor,
                          hint: LocaleKeys.birth_date.tr(),
                          readOnly: true,
                          suffixIcon: IconButton(
                            icon: SvgPicture.asset(
                              Assets.icons.calender,
                              width: 20.w,
                              height: 20.h,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDatePicker(
                                    onDateSelected: (selectedDate) {
                                      cubit.updateBirthDate(selectedDate
                                          .toString()
                                          .split(' ')[0]);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDatePicker(
                                  onDateSelected: (selectedDate) {
                                    cubit.updateBirthDate(
                                        selectedDate.toString().split(' ')[0]);
                                  },
                                );
                              },
                            );
                          },
                          validator: (_) => (state is SignUpFormInvalid &&
                                  state.birthDateError != null)
                              ? state.birthDateError
                              : null,
                        ),
                        if (state is SignUpFormInvalid &&
                            state.birthDateError != null)
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              state.birthDateError!,
                              style: TextStyle(color: AppColors.error),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomElevatedButton(
                    onPressed: () {
                      cubit.submitForm();
                    },
                    label: LocaleKeys.continues.tr(),
                  ),
                  SizedBox(height: 8.h),
                  const AlreadyHaveAccountRow(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
