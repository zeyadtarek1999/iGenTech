import 'package:dartz/dartz.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:iGenTech/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:iGenTech/features/sign_in/data/data_sources/sign_in_local_data_source.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInLocalDataSource localDataSource;

  SignInRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> signIn(SignInEntity authEntity) async {
    try {
      final bool isAuthenticated = await localDataSource.authenticateUser(authEntity);

      if (isAuthenticated) {
        return Right(true);
      } else {
        return Left(CacheFailure('Invalid email or password'));
      }
    } catch (error) {
      return Left(ServerFailure('Authentication failed: ${error.toString()}'));
    }
  }
}
