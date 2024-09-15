import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/app.dart';
import 'package:iGenTech/core/utils/app_colors.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 28.sp,
                color: AppColors.bgColor,
              ),
               SizedBox(width: 16.w),
              Text(
                title,
                style:  TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              const Spacer(),
               Icon(
                Icons.arrow_forward_ios,
                size: 18.sp,
                color: AppColors.hintColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
