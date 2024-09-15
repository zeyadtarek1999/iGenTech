import 'package:dartz/dartz.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getProfileByEmail(String email);
}
