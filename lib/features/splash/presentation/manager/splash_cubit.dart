import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:iGenTech/core/helpers/shared_prefrences.dart';
import 'package:iGenTech/core/app_constants/local_cache_keys.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CacheHelper cacheHelper;

  SplashCubit(this.cacheHelper) : super(SplashInitial());

  void startAnimation() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      emit(SplashAnimating(5.0));
    });

    Future.delayed(const Duration(seconds: 2), () {
      bool isOnBoardingSeen = cacheHelper.getData(key: AppLocalCacheKey.onBoardingSeen) ?? false;
      if (isOnBoardingSeen) {
        emit(SplashNavigateToHome());
      } else {
        emit(SplashNavigateToOnboarding());
      }
    });
  }
}
