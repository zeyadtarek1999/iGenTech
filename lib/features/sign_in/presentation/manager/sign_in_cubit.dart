import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/core/validations/bio_metric_auth.dart';
import 'package:iGenTech/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:iGenTech/features/sign_in/domain/use_cases/sign_in_uc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;
  final BiometricAuth biometricAuth;

  SignInCubit({required this.signInUseCase, required this.biometricAuth}) : super(SignInInitial());

  String? email;
  String? password;
  bool isPasswordVisible = false;

  void updateEmail(String value) {
    email = value;
    emit(SignInUpdated());
  }

  void updatePassword(String value) {
    password = value;
    emit(SignInUpdated());
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SignInUpdated());
  }

  Future<void> signIn() async {
    if (email != null && password != null) {
      emit(SignInLoading());

      final List<BiometricType> availableBiometrics = await biometricAuth.getAvailableBiometrics();

      if (availableBiometrics.isNotEmpty) {
        final bool isAuthenticated = await biometricAuth.authenticateWithBiometrics(
          reason: 'Please authenticate to login',
        );

        if (isAuthenticated) {
          debugPrint('Biometric authentication successful.');
          _performSignIn();
        } else {
          debugPrint('Biometric authentication failed.');
          emit(SignInFailure("Biometric authentication failed"));
        }
      } else {
        debugPrint('Biometric authentication is not available.');
        _performSignIn();
      }
    } else {
      emit(SignInFailure("Email or password is missing"));
    }
  }

  Future<void> _performSignIn() async {
    final signInEntity = SignInEntity(email: email!, password: password!);
    final Either<Failure, bool> result = await signInUseCase.signIn(signInEntity);

    result.fold(
          (failure) => emit(SignInFailure(failure.massage)),
          (success) {
        if (success) {
          emit(SignInSuccess());
        } else {
          emit(SignInFailure("Invalid email or password"));
        }
      },
    );
  }
}
