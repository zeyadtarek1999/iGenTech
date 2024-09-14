import 'package:dartz/dartz.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:iGenTech/features/sign_up/domain/repositories/sign_up_repository.dart';

abstract class SignUpUseCase {
  Future<Either<Failure, void>> signUp(User user);
}

class SignUpUseCaseImpl implements SignUpUseCase {
  final SignUpRepository userRepository;

  SignUpUseCaseImpl(this.userRepository);

  @override
  Future<Either<Failure, void>> signUp(User user) async {
    return await userRepository.saveUser(user);
  }
}
