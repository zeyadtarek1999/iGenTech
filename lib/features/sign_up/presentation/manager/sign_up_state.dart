part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpFormUpdated extends SignUpState {
  final String passwordStrength;
  final bool hasMinLength;
  final bool hasNoNameOrEmail;
  final bool hasSymbolOrNumber;
  final bool hasNoSpaces;

  SignUpFormUpdated({
    required this.passwordStrength,
    required this.hasMinLength,
    required this.hasNoNameOrEmail,
    required this.hasSymbolOrNumber,
    required this.hasNoSpaces,
  });
}

class SignUpFormInvalid extends SignUpState {
  final String? passwordError;

  SignUpFormInvalid({this.passwordError});
}

class SignUpSubmitted extends SignUpState {}
