import 'package:bloc_clean_architecture_tdd_solid/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailNPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginWithEmailNPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<String> loginWithEmailNPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailNPassword({ 
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user != null) {
        return response.user!.id;
      } else {
        throw const ServerException('User not created!');
      }
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }
}
