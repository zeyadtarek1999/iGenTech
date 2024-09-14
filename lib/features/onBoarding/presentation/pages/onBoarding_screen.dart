import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/config/routes/app_routes.dart';
import 'package:iGenTech/features/onBoarding/presentation/manager/onboarding_cubit.dart';
import 'package:iGenTech/core/utils/app_colors.dart';
import 'package:iGenTech/features/onBoarding/presentation/widgets/onBoarding_widget.dart';
import 'package:iGenTech/generated/assets.gen.dart';
import 'package:iGenTech/generated/locale_keys.g.dart';
import 'package:iGenTech/shared_widgets/custom_app_bar.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
        if (state is OnBoardingCompleted && state.isCompleted) {
          Navigator.pushReplacementNamed(context, AppRoutes.signUpScreenRoute);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: const CustomAppBar(
          showTitle: false,
          showBackButton: false,
        ),
        body: BlocBuilder<OnBoardingCubit, OnBoardingState>(
          builder: (context, state) {
            int currentPage = 0;
            if (state is OnBoardingPageChanged) {
              currentPage = state.currentPage;
            }

            return Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: context.read<OnBoardingCubit>().pageController,
                    onPageChanged: (index) {
                      context.read<OnBoardingCubit>().setPage(index);
                    },
                    children: [
                      OnBoardingWidget(
                        image: Assets.images.whoWeAre.path,
                        title: LocaleKeys.whoWeAre.tr(),
                        subtitle: LocaleKeys.whoWeAreSubtitle.tr(),
                      ),
                      OnBoardingWidget(
                        image: Assets.images.mission.path,
                        title: LocaleKeys.ourMission.tr(),
                        subtitle: LocaleKeys.missionSubtitle.tr(),
                      ),
                      OnBoardingWidget(
                        image: Assets.images.mission.path,
                        title: LocaleKeys.ourVision.tr(),
                        subtitle: LocaleKeys.visionSubtitle.tr(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.read<OnBoardingCubit>().skipOnBoarding();
                        },
                        child: Text(
                          LocaleKeys.skip.tr(),
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.secTextColor,
                          ),
                        ),
                      ),
                      Row(
                        children: List.generate(3, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: currentPage == index ? 12 : 8,
                            height: currentPage == index ? 12 : 8,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? AppColors.mainColor
                                  : AppColors.secondColor,
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                      TextButton(
                        onPressed: () {
                          if (currentPage == 2) {
                            context.read<OnBoardingCubit>().completeOnBoarding();
                          } else {
                            context.read<OnBoardingCubit>().nextPage();
                          }
                        },
                        child: Text(
                          currentPage == 2 ? LocaleKeys.done.tr() : LocaleKeys.next.tr(),
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
