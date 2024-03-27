import 'package:bloc_clean_architecture_tdd_solid/core/error/exceptions.dart';
import 'package:bloc_clean_architecture_tdd_solid/core/error/failures.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/domain/repository/auth.repository.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/user.entity.dart';
import '../datasources/auth.remote.data.sources.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> loginWithEmailNPassword({
    required String email,
    required String password,
  }) async {
    return await _getUser(
        () async => await remoteDataSource.loginWithEmailNPassword(
              email: email,
              password: password,
            ));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailNPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _getUser(
        () async => await remoteDataSource.signUpWithEmailNPassword(
              name: name,
              email: email,
              password: password,
            ));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();

      return Right(user);
    } on ServerException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}
