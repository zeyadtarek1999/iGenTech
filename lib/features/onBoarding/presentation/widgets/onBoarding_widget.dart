import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/core/utils/app_colors.dart';

class OnBoardingWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const OnBoardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, width: 300.w, height: 300.h),
          SizedBox(height: 20.h),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.mainTextColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
