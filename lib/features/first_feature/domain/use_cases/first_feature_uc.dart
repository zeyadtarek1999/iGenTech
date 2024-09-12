import 'package:dartz/dartz.dart';
import 'package:iGenTech/core/error/failures.dart';
import 'package:iGenTech/core/usecases/usecase.dart';
import 'package:iGenTech/features/first_feature/domain/entities/cat_fact_entity.dart';
import 'package:iGenTech/features/first_feature/domain/repositories/first_feature_repo.dart';

class FirstFeatureUc implements UseCase<CatFactEntity, NoParams> {
  final FirstFeatureRepository firstFeatureRepository;

  FirstFeatureUc({required this.firstFeatureRepository});

  @override
  Future<Either<Failure, CatFactEntity>> call(NoParams params) {
    return firstFeatureRepository.getCatFact();
  }
}
