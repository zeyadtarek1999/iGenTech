import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/app.dart';
import 'package:iGenTech/core/utils/app_colors.dart';

class PopUp {
  static void showPopup(BuildContext context, String title, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,dialogBackgroundColor: AppColors.logoMainColor,
      title: title,titleTextStyle: TextStyle(color: AppColors.logoSecColor,fontWeight: FontWeight.w600,fontSize: 20.sp),
      desc: message,descTextStyle: TextStyle(color: AppColors.white,fontWeight: FontWeight.w600,fontSize: 16.sp),
      btnOkOnPress: () {},
      btnOkText: 'Close',
      btnOkColor: AppColors.logoSecColor,
      headerAnimationLoop: false,
    ).show();
  }
}
