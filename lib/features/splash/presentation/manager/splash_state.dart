part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashAnimating extends SplashState {
  final double value;
  SplashAnimating(this.value);
}

class SplashNavigateToHome extends SplashState {}

class SplashNavigateToOnboarding extends SplashState {}
