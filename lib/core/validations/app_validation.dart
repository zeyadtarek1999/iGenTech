

import 'package:easy_localization/easy_localization.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';

class AppValidator {
  static noValidation() {
    return null;
  }

  static String? emailValidation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.enterYourEmail.tr();
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    String trimmedValue = value.trim();

    if (!emailRegex.hasMatch(trimmedValue)) {
      return LocaleKeys.enterValidEmail.tr();
    }

    return null;
  }

  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.enterYourPassword.tr();
    }

    bool hasMinLength = value.length >= 8;
    bool hasSymbolOrNumber = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>0-9]'));
    bool hasNoSpaces = !value.contains(' ');
    bool hasNoNameOrEmail = !value.contains(RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'));

    if (!hasMinLength) {
      return LocaleKeys.password_min_length.tr();
    }
    if (!hasSymbolOrNumber) {
      return LocaleKeys.password_symbol_or_number.tr();
    }
    if (!hasNoSpaces) {
      return LocaleKeys.password_no_spaces.tr();
    }
    if (!hasNoNameOrEmail) {
      return LocaleKeys.password_no_name_or_email.tr();
    }

    return null;
  }
  static String? phoneValidation(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.enterPhoneNumber.tr();
    }
    return null;
  }

  static String? nameValidation(String? name) {
    if (name == null || name.isEmpty) {
      return LocaleKeys.nameRequired.tr();
    }
    return null;
  }

  static String? addressValidation(String? address) {
    if (address == null || address.isEmpty) {
      return LocaleKeys.addressRequired.tr();
    }
    return null;
  }

  static String? zipCodeValidation(String? zipCode) {
    if (zipCode == null || zipCode.isEmpty) {
      return LocaleKeys.zipCodeRequired.tr();
    }
    if (!RegExp(r'^\d{5}(-\d{4})?$').hasMatch(zipCode)) {
      return LocaleKeys.enterValidZipCode.tr();
    }
    return null;
  }

  static String? birthDateValidation(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.birthDateRequired.tr();
    }




    return null;
  }
}
