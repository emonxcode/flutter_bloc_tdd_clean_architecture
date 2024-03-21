import 'package:bloc_clean_architecture_tdd_solid/core/errors/failure.dart';
import 'package:bloc_clean_architecture_tdd_solid/src/authentication/domain/repositories/authentication.repository.dart';
import 'package:bloc_clean_architecture_tdd_solid/src/authentication/domain/usecases/create.user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// What does the class depend on
/// Answer: AuthenticationRepository
/// How can we create a fake version of the dependency
/// Answer: Use Mocktail
/// How do we control what our dependencies do
/// Answer: Using the Mocktail's APIs

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  // setUp(() {
  //   usecase = CreateUser(MockAuthenticationRepository());
  // });

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test('should call the [Repository.createUser]', () async {
    // Arrange
    when(
      () => repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      ),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
