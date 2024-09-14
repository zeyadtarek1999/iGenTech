import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  String? fullName;
  String? email;
  String? gender;
  String? birthDate;
  String? password;
  String? confirmPassword;

  bool hasMinLength = false;
  bool hasNoNameOrEmail = true;
  bool hasSymbolOrNumber = false;
  bool hasNoSpaces = true;
  String passwordStrength = 'weak';

  void updateFullName(String name) {
    fullName = name;
    emit(SignUpFormUpdated(
      passwordStrength: passwordStrength,
      hasMinLength: hasMinLength,
      hasNoNameOrEmail: hasNoNameOrEmail,
      hasSymbolOrNumber: hasSymbolOrNumber,
      hasNoSpaces: hasNoSpaces,
    ));
  }

  void updateEmail(String emailValue) {
    email = emailValue;
    _validatePasswordStrength(password ?? '');
    emit(SignUpFormUpdated(
      passwordStrength: passwordStrength,
      hasMinLength: hasMinLength,
      hasNoNameOrEmail: hasNoNameOrEmail,
      hasSymbolOrNumber: hasSymbolOrNumber,
      hasNoSpaces: hasNoSpaces,
    ));
  }

  void updateGender(String selectedGender) {
    gender = selectedGender;
    emit(SignUpFormUpdated(
      passwordStrength: passwordStrength,
      hasMinLength: hasMinLength,
      hasNoNameOrEmail: hasNoNameOrEmail,
      hasSymbolOrNumber: hasSymbolOrNumber,
      hasNoSpaces: hasNoSpaces,
    ));
  }

  void updateBirthDate(String date) {
    birthDate = date;
    emit(SignUpFormUpdated(
      passwordStrength: passwordStrength,
      hasMinLength: hasMinLength,
      hasNoNameOrEmail: hasNoNameOrEmail,
      hasSymbolOrNumber: hasSymbolOrNumber,
      hasNoSpaces: hasNoSpaces,
    ));
  }

  void updatePassword(String pwd) {
    password = pwd;
    _validatePasswordStrength(pwd);
    emit(SignUpFormUpdated(
      passwordStrength: passwordStrength,
      hasMinLength: hasMinLength,
      hasNoNameOrEmail: hasNoNameOrEmail,
      hasSymbolOrNumber: hasSymbolOrNumber,
      hasNoSpaces: hasNoSpaces,
    ));
  }

  void updateConfirmPassword(String confirmPwd) {
    confirmPassword = confirmPwd;
    emit(SignUpFormUpdated(
      passwordStrength: passwordStrength,
      hasMinLength: hasMinLength,
      hasNoNameOrEmail: hasNoNameOrEmail,
      hasSymbolOrNumber: hasSymbolOrNumber,
      hasNoSpaces: hasNoSpaces,
    ));
  }

  void _validatePasswordStrength(String pwd) {
    hasMinLength = pwd.length >= 8;
    hasNoNameOrEmail = !(pwd.contains(fullName ?? '') || pwd.contains(email ?? ''));
    hasSymbolOrNumber = RegExp(r'[!@#$%^&*(),.?":{}|<>0-9]').hasMatch(pwd);
    hasNoSpaces = !pwd.contains(' ');

    if (hasMinLength && hasNoNameOrEmail && hasSymbolOrNumber && hasNoSpaces) {
      passwordStrength = 'excellent';
    } else if (hasMinLength && (hasSymbolOrNumber || hasNoNameOrEmail)) {
      passwordStrength = 'good';
    } else {
      passwordStrength = 'weak';
    }
  }

  String? confirmPasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  void submitForm() {
    if (fullName != null && email != null && password != null && confirmPassword != null) {
      if (password == confirmPassword) {
        emit(SignUpSubmitted());
      } else {
        emit(SignUpFormInvalid(passwordError: 'Passwords do not match'));
      }
    } else {
      emit(SignUpFormInvalid(passwordError: 'Please fill all fields'));
    }
  }
}
