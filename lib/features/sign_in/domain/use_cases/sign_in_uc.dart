import 'package:dartz/dartz.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:iGenTech/features/sign_in/domain/repositories/sign_in_repository.dart';

abstract class SignInUseCase {
  Future<Either<Failure, bool>> signIn(SignInEntity authEntity);
}

class SignInUseCaseImpl implements SignInUseCase {
  final SignInRepository authRepository;

  SignInUseCaseImpl(this.authRepository);

  @override
  Future<Either<Failure, bool>> signIn(SignInEntity authEntity) async {
    try {
      return await authRepository.signIn(authEntity);
    } catch (e) {
      return const Left(ServerFailure('Sign-in failed.'));
    }
  }
}
