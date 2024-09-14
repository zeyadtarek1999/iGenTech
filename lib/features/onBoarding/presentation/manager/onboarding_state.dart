part of 'onboarding_cubit.dart';

@immutable
abstract class OnBoardingState {}

class OnBoardingInitial extends OnBoardingState {
  final int currentPage;

  OnBoardingInitial(this.currentPage);
}

class OnBoardingPageChanged extends OnBoardingState {
  final int currentPage;

  OnBoardingPageChanged(this.currentPage);
}

class OnBoardingCompleted extends OnBoardingState {
  final bool isCompleted;

  OnBoardingCompleted(this.isCompleted);
}
