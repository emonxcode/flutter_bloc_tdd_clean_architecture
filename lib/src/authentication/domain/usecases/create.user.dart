import 'package:bloc_clean_architecture_tdd_solid/core/usecases/usecase.dart';
import 'package:bloc_clean_architecture_tdd_solid/core/utils/typedef.dart';
import 'package:bloc_clean_architecture_tdd_solid/src/authentication/domain/repositories/authentication.repository.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams.empty() : this(createdAt: '_empty.string', name:  '_empty.string', avatar:  '_empty.string');

  const CreateUserParams(
      {required this.createdAt, required this.name, required this.avatar});

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
