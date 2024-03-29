import 'package:bloc_clean_architecture_tdd_solid/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract interface class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}
