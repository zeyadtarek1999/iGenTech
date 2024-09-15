import 'package:dartz/dartz.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/features/profile/domain/entities/profile_entity.dart';
import 'package:iGenTech/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, UserProfile>> execute({required String email}) async {
    return await repository.getProfileByEmail(email);
  }
}
