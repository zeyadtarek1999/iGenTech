import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/core/utils/app_colors.dart';

class PasswordRequirementWidget extends StatelessWidget {
  final String requirement;
  final bool fulfilled;

  const PasswordRequirementWidget({
    super.key,
    required this.requirement,
    required this.fulfilled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          fulfilled ? Icons.check_circle : Icons.error,
          color: fulfilled ? AppColors.mainColor : AppColors.error,
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          requirement,
          style: TextStyle(
            color: fulfilled ? Colors.white : AppColors.error,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
