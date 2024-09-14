import 'package:dartz/dartz.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/features/sign_up/domain/entities/sign_up_entity.dart';

abstract class SignUpRepository {
  Future<Either<Failure, void>> saveUser(User user);
  Future<Either<Failure, User?>> getUser(String email);
  Future<Either<Failure, bool>> isEmailRegistered(String email);
}
