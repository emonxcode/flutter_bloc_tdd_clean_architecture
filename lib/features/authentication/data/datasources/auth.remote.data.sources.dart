import 'package:bloc_clean_architecture_tdd_solid/core/error/exceptions.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/data/models/user.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailNPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailNPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<UserModel> loginWithEmailNPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUpWithEmailNPassword({
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
        return UserModel.fromJson(response.user!.toJson());
      } else {
        throw const ServerException('User not created!');
      }
    } catch (exception) {
      throw exception.toString();
    }
  }
}
