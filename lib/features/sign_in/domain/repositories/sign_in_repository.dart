import 'package:dartz/dartz.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/features/sign_in/domain/entities/sign_in_entity.dart';

abstract class SignInRepository {
  Future<Either<Failure, bool>> signIn(SignInEntity authEntity);
}
