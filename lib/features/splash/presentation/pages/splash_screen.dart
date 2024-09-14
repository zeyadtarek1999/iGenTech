import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/config/routes/app_routes.dart';
import 'package:iGenTech/features/splash/presentation/manager/splash_cubit.dart';
import 'package:iGenTech/generated/assets.gen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashCubit>().startAnimation();

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToHome) {
          Navigator.pushReplacementNamed(context, AppRoutes.signInScreenRoute);
        } else if (state is SplashNavigateToOnboarding) {
          Navigator.pushReplacementNamed(context, AppRoutes.onBoardingScreenRoute);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Assets.icons.igentechLogo.image(
                width: double.infinity,
                height: 300.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20.h),
              // Animated Text
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Disturbing The ',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.secTextColor,
                      ),
                    ),
                    TextSpan(
                      text: 'Fintech',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.mainTextColor,
                      ),
                    ),
                    TextSpan(
                      text: ' Industry...',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.secTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
