import 'package:bloc_clean_architecture_tdd_solid/core/error/failures.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/domain/entities/user.entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailNPassword({
    required String name,
    required String email,
    required String password,
  });

   Future<Either<Failure, User>> loginWithEmailNPassword({
    required String email,
    required String password,
  });
}
