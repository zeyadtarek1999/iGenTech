part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpFormUpdated extends SignUpState {
  final String? nameError;
  final String? emailError;
  final String? birthDateError;
  final String? passwordError;
  final String passwordStrength;
  final bool hasMinLength;
  final bool hasNoNameOrEmail;
  final bool hasSymbolOrNumber;
  final bool hasNoSpaces;

  SignUpFormUpdated({
    this.nameError,
    this.emailError,
    this.birthDateError,
    this.passwordError,
    required this.passwordStrength,
    required this.hasMinLength,
    required this.hasNoNameOrEmail,
    required this.hasSymbolOrNumber,
    required this.hasNoSpaces,
  });
}

class SignUpFormInvalid extends SignUpState {
  final String? nameError;
  final String? emailError;
  final String? birthDateError;
  final String? passwordError;

  SignUpFormInvalid({
    this.nameError,
    this.emailError,
    this.birthDateError,
    this.passwordError,
  });
}

class SignUpEmailAlreadyRegistered extends SignUpState {
  final String emailError;

  SignUpEmailAlreadyRegistered({required this.emailError});
}

class SignUpSubmitted extends SignUpState {}

class SignUpGenderUpdated extends SignUpState {
  final String gender;

  SignUpGenderUpdated({required this.gender});
}

class SignUpBirthDateUpdated extends SignUpState {
  final String birthDate;

  SignUpBirthDateUpdated({required this.birthDate});
}

class SignUpPasswordVisibilityToggled extends SignUpState {
  final bool isPasswordVisible;

  SignUpPasswordVisibilityToggled({required this.isPasswordVisible});
}

class SignUpConfirmPasswordVisibilityToggled extends SignUpState {
  final bool isConfirmPasswordVisible;

  SignUpConfirmPasswordVisibilityToggled({required this.isConfirmPasswordVisible});
}
