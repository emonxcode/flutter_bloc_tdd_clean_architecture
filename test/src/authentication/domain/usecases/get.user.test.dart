import 'package:bloc_clean_architecture_tdd_solid/src/authentication/domain/entities/user.dart';
import 'package:bloc_clean_architecture_tdd_solid/src/authentication/domain/repositories/authentication.repository.dart';
import 'package:bloc_clean_architecture_tdd_solid/src/authentication/domain/usecases/get.users.dart';
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
  late GetUsers usecase;
  late AuthenticationRepository repository;

  // setUp(() {
  //   usecase = CreateUser(MockAuthenticationRepository());
  // });

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = GetUsers(repository);
  });

  const tResponse = [User.empty()];

  test('should call the [Repository.getUsers]', () async {
    // Arrange
    when(
      () => repository.getUsers(),
    ).thenAnswer((_) async => const Right(tResponse));

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
    verify(
      () => repository.getUsers(),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
