
import 'package:iGenTech/features/onBoarding/presentation/pages/onBoarding_screen.dart';
import 'package:iGenTech/features/sign_up/presentation/pages/sign_up_screen.dart';
import 'package:iGenTech/features/splash/presentation/pages/splash_screen.dart';

import '../../features/first_feature/presentation/screens/feature_screen.dart';

class AppRoutes {
  static String homeScreenRoute = 'homeScreen';
  static String splashScreenRoute = 'splashScreen';
  static String onBoardingScreenRoute = 'onBoardingScreen';
  static String signUpScreenRoute = 'signUpScreen';

  static get routes {
    return {
      AppRoutes.homeScreenRoute: (context) => const HomeScreen(),
      AppRoutes.splashScreenRoute: (context) => const SplashScreen(),
      AppRoutes.onBoardingScreenRoute: (context) =>  const OnBoardingScreen(),
      AppRoutes.signUpScreenRoute: (context) =>  const SignUpScreen(),
    };
  }
}
