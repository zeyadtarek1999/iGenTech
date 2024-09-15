import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/core/services/url_launcher_service.dart';
import 'package:iGenTech/features/profile/domain/entities/profile_entity.dart';
import 'package:iGenTech/features/profile/domain/use_cases/get_profile_uc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  final UrlLauncherService urlLauncherService;

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController genderController;
  late TextEditingController birthDateController;

  double? latitude;
  double? longitude;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.urlLauncherService,
  }) : super(ProfileInitial());

  Future<void> loadProfile(String email) async {
    emit(ProfileLoading());

    final Either<Failure, UserProfile> result = await getProfileUseCase.execute(email: email);

    result.fold(
          (failure) {
        debugPrint('Failed to load profile: ${failure.massage}');
        emit(ProfileError(failure.massage));
      },
          (profile) {
        debugPrint('Profile loaded successfully for email: $email');

        fullNameController = TextEditingController(text: profile.fullName);
        emailController = TextEditingController(text: profile.email);
        genderController = TextEditingController(text: profile.gender);
        birthDateController = TextEditingController(text: profile.birthDate);

        latitude = profile.latitude;
        longitude = profile.longitude;

        emit(ProfileLoaded(profile));
      },
    );
  }

  Future<void> openMap() async {
    if (latitude != null && longitude != null) {
      try {
        await urlLauncherService.openMap(latitude!, longitude!);
      } catch (e) {
        debugPrint('Failed to open Google Maps: $e');
      }
    } else {
      debugPrint('Latitude or Longitude is null, cannot open map.');
    }
  }



  @override
  Future<void> close() {
    fullNameController.dispose();
    emailController.dispose();
    genderController.dispose();
    birthDateController.dispose();
    return super.close();
  }
}
