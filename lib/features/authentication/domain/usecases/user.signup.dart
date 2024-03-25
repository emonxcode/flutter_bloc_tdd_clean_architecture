import 'package:bloc_clean_architecture_tdd_solid/core/error/failures.dart';
import 'package:bloc_clean_architecture_tdd_solid/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../repository/auth.repository.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
   return await authRepository.signUpWithEmailNPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
