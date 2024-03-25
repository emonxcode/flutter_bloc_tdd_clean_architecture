import 'package:bloc_clean_architecture_tdd_solid/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailNPassword({
    required String name,
    required String email,
    required String password,
  });

   Future<Either<Failure, String>> loginWithEmailNPassword({
    required String email,
    required String password,
  });
}
