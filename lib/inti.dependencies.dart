import 'package:bloc_clean_architecture_tdd_solid/features/authentication/data/datasources/auth.remote.data.sources.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/data/repositories/auth.repository.impl.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/domain/repository/auth.repository.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/domain/usecases/user.login.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/domain/usecases/user.signup.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/secrets/app.secrets.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _intiAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(
      () => supabase.client); // only create instance once for full app lifetime
}

void _intiAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      supabaseClient: serviceLocator<SupabaseClient>(),
    ),
  ); // create new instance every time needed

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

    serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
    ),
  );
}
