import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/core/utils/app_colors.dart';

class FormFieldSection extends StatelessWidget {
  final String label;
  final Widget child;

  const FormFieldSection({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.thirdTextColor,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 10.h),
        child,
      ],
    );
  }
}
