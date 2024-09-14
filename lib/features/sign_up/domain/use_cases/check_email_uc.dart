import 'package:dartz/dartz.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/features/sign_up/domain/repositories/sign_up_repository.dart';

class CheckEmailUseCase {
  final SignUpRepository repository;

  CheckEmailUseCase(this.repository);

  Future<Either<Failure, bool>> call(String email) {
    return repository.isEmailRegistered(email);
  }
}
