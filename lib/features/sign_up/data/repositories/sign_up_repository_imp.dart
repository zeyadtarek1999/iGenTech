import 'package:dartz/dartz.dart';
import 'package:iGenTech/core/error/exceptions.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/features/sign_up/data/data_sources/sign_up_data_local_source.dart';
import 'package:iGenTech/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:iGenTech/features/sign_up/domain/repositories/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpLocalDataSource localDataSource;

  SignUpRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> saveUser(User user) async {
    try {
      await localDataSource.saveUser(user);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure('Failed to save user: ${e.message}'));
    } catch (e) {
      return Left(CacheFailure('An unknown error occurred while saving user: $e'));
    }
  }

  @override
  Future<Either<Failure, User?>> getUser(String email) async {
    try {
      final user = await localDataSource.getUser(email);
      return Right(user);
    } on CacheException catch (e) {
      return Left(CacheFailure('Failed to retrieve user: ${e.message}'));
    } catch (e) {
      return Left(CacheFailure('An unknown error occurred while retrieving user: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isEmailRegistered(String email) async {
    try {
      final user = await localDataSource.getUser(email);
      if (user != null) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure('Failed to check email: ${e.message}'));
    } catch (e) {
      return Left(CacheFailure('An unknown error occurred while checking email: $e'));
    }
  }
}
