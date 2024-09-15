import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:iGenTech/core/app_constants/local_cache_keys.dart';
import 'package:iGenTech/core/helpers/shared_prefrences.dart';
import 'package:iGenTech/injection_container.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final CacheHelper cacheHelper;
  final PageController pageController = PageController();
  int currentPage = 0;

  OnBoardingCubit(this.cacheHelper) : super(OnBoardingInitial(0));

  void setPage(int page) {
    currentPage = page;
    emit(OnBoardingPageChanged(currentPage));
  }

  void nextPage() {
    if (currentPage < 2) {
      currentPage++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(OnBoardingPageChanged(currentPage));
    } else {
      emit(OnBoardingPageChanged(currentPage));
    }
  }

  void completeOnBoarding() {
    getIt<CacheHelper>().saveData(
      key: AppLocalCacheKey.onBoardingSeen,
      val: true,
    );
    emit(OnBoardingCompleted(true));
  }

  void skipOnBoarding() {
    getIt<CacheHelper>().saveData(
      key: AppLocalCacheKey.onBoardingSeen,
      val: true,
    );
    emit(OnBoardingCompleted(true));
  }
}
