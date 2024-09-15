import 'package:dartz/dartz.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/features/profile/data/data_sources/profile_local_data_source.dart';
import 'package:iGenTech/features/profile/domain/entities/profile_entity.dart';
import 'package:iGenTech/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter/foundation.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, UserProfile>> getProfileByEmail(String email) async {
    try {
      final Map<String, dynamic>? profileData = await localDataSource.getProfileDataByEmail(email);

      if (profileData != null) {
        final profile = UserProfile.fromJson(profileData);
        debugPrint('ProfileRepositoryImpl: Profile found for email: $email');
        return Right(profile);
      } else {
        debugPrint('ProfileRepositoryImpl: User not found with email: $email');
        return Left(CacheFailure('User not found with email: $email'));
      }
    } catch (e, stacktrace) {
      debugPrint('ProfileRepositoryImpl: Error fetching profile by email: $e');
      debugPrint('Stacktrace: $stacktrace');
      return Left(CacheFailure('Error fetching profile: $e'));
    }
  }


}
