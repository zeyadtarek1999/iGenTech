import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iGenTech/features/onBoarding/presentation/manager/onboarding_cubit.dart';
import 'package:iGenTech/features/sign_in/presentation/manager/sign_in_cubit.dart';
import 'package:iGenTech/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:iGenTech/features/splash/presentation/manager/splash_cubit.dart';

import 'app.dart';
import 'core/observers/bloc_observer.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  EasyLocalization.ensureInitialized();
  await getItInit();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/languages',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => getIt<SplashCubit>(),
            ),
            BlocProvider(
              create: (_) => getIt<OnBoardingCubit>(),
            ),
            BlocProvider(
              create: (_) => getIt<SignUpCubit>(),
            ),
            BlocProvider(
              create: (_) => getIt<SignInCubit>(),
            ),
          ],
        child: const MyApp(),
      ),
  ),
  );
}