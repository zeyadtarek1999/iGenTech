import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/core/services/geo_location_service.dart';
import 'package:iGenTech/core/services/permission_service.dart';
import 'package:iGenTech/core/validations/app_validation.dart';
import 'package:iGenTech/core/validations/bio_metric_auth.dart';
import 'package:iGenTech/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:iGenTech/features/sign_up/domain/use_cases/sign_up_uc.dart';
import 'package:iGenTech/features/sign_up/domain/use_cases/check_email_uc.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';

part 'sign_up_state.dart';


class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase signUpUseCase;
  final CheckEmailUseCase checkEmailUseCase;
  final BiometricAuth biometricAuth;
  final PermissionService permissionService;
  final LocationService locationService;

  SignUpCubit({
    required this.signUpUseCase,
    required this.checkEmailUseCase,
    required this.biometricAuth,
    required this.permissionService,
    required this.locationService,
  }) : super(SignUpInitial());

  String? fullName;
  String? email;
  String? gender;
  String? birthDate;
  TextEditingController birthDateController = TextEditingController();
  String? password;
  String? confirmPassword;

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Future<void> close() {
    birthDateController.dispose();
    return super.close();
  }

  void _emitUpdatedState() {
    final nameError = AppValidator.nameValidation(fullName);
    final emailError = AppValidator.emailValidation(email);
    final birthDateError = AppValidator.birthDateValidation(birthDate);

    emit(SignUpFormUpdated(
      nameError: nameError,
      emailError: emailError,
      birthDateError: birthDateError,
      passwordStrength: '',
      hasMinLength: false,
      hasNoNameOrEmail: false,
      hasSymbolOrNumber: false,
      hasNoSpaces: false,
    ));
  }

  void updateFullName(String name) {
    fullName = name;
    _emitUpdatedState();
  }

  void updateEmail(String emailValue) {
    email = emailValue;
    _emitUpdatedState();
  }

  void updateGender(String selectedGender) {
    gender = selectedGender;
    emit(SignUpGenderUpdated(gender: selectedGender));
  }

  void updateBirthDate(String date) {
    birthDate = date;
    birthDateController.text = date;
    _emitUpdatedState();
  }

  void updatePassword(String pwd) {
    password = pwd;
    _emitUpdatedState();
  }

  void updateConfirmPassword(String confirmPwd) {
    confirmPassword = confirmPwd;
    _emitUpdatedState();
  }

  Future<void> submitForm() async {
    final nameError = AppValidator.nameValidation(fullName);
    final emailError = AppValidator.emailValidation(email);
    final birthDateError = AppValidator.birthDateValidation(birthDate);

    if (nameError == null && emailError == null && birthDateError == null) {
      emit(SignUpFormUpdated(
        nameError: nameError,
        emailError: emailError,
        birthDateError: birthDateError,
        passwordStrength: '',
        hasMinLength: false,
        hasNoNameOrEmail: false,
        hasSymbolOrNumber: false,
        hasNoSpaces: false,
      ));

      final Either<Failure, bool> result = await checkEmailUseCase(email!);
      result.fold(
            (failure) => emit(SignUpFormInvalid(emailError: "Error checking email")),
            (isEmailRegistered) {
          if (isEmailRegistered) {
            emit(SignUpEmailAlreadyRegistered(
              emailError: LocaleKeys.email_already_registered.tr(),
            ));
          } else {
            emit(SignUpSubmitted());
          }
        },
      );
    } else {
      emit(SignUpFormInvalid(
        nameError: nameError,
        emailError: emailError,
        birthDateError: birthDateError,
      ));
    }
  }

  Future<void> submitPasswordForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      if (password != null && password == confirmPassword) {
        final bool isBiometricAvailable = await biometricAuth.isBiometricAvailable();

        if (isBiometricAvailable) {
          final bool isAuthenticated = await biometricAuth.authenticateWithBiometrics(
            reason: LocaleKeys.bio_auth_prompt.tr(),
          );

          if (isAuthenticated) {
            // Request location permission
            await permissionService.requestLocationPermission();

            final Position? position = await locationService.getCurrentLocation();

            if (position != null) {
              final user = User(
                fullName: fullName!,
                email: email!,
                gender: gender!,
                birthDate: birthDate!,
                password: password!,
                latitude: position.latitude,
                longitude: position.longitude,
              );

              final Either<Failure, void> result = await signUpUseCase.signUp(user);

              result.fold(
                    (failure) => emit(SignUpFormInvalid(passwordError: "Error during sign-up: ${failure.massage}")),
                    (_) => emit(SignUpSubmitted()),
              );
            } else {
              emit(SignUpFormInvalid(passwordError: "Unable to retrieve location"));
            }
          } else {
            emit(SignUpFormInvalid(passwordError: "Biometric authentication failed"));
          }
        } else {
          emit(SignUpFormInvalid(passwordError: "Biometric authentication is not available"));
        }
      } else {
        emit(SignUpFormInvalid(passwordError: "Passwords do not match"));
      }
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SignUpPasswordVisibilityToggled(isPasswordVisible: isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(SignUpConfirmPasswordVisibilityToggled(isConfirmPasswordVisible: isConfirmPasswordVisible));
  }
}
