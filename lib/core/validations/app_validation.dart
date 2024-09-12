

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
    if (value.length < 6) {
      return LocaleKeys.passwordAtLeast6.tr();
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
}
