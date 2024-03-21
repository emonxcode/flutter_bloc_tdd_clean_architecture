import 'package:bloc_clean_architecture_tdd_solid/core/usecases/usecase.dart';
import 'package:bloc_clean_architecture_tdd_solid/core/utils/typedef.dart';
import 'package:bloc_clean_architecture_tdd_solid/src/authentication/domain/entities/user.dart';
import 'package:bloc_clean_architecture_tdd_solid/src/authentication/domain/repositories/authentication.repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
 