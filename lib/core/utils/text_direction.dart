import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

ui.TextDirection getTextDirection(BuildContext context) {
  return context.locale.languageCode == 'ar'
      ? ui.TextDirection.rtl
      : ui.TextDirection.ltr;
}
