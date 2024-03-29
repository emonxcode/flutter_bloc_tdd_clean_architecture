import 'package:bloc_clean_architecture_tdd_solid/core/error/exceptions.dart';
import 'package:bloc_clean_architecture_tdd_solid/features/authentication/data/models/user.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel> signUpWithEmailNPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailNPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailNPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user != null) {
        return UserModel.fromJson(response.user!.toJson());
      } else {
        throw const ServerException('Failed to login!');
      }
    } on AuthException catch (exception) {
      throw ServerException(exception.message);
    }
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
    } on AuthException catch (exception) {
      throw ServerException(exception.message);
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first)
            .copyWith(email: currentUserSession!.user.email);
      }

      return null;
    } on AuthException catch (exception) {
      throw ServerException(exception.message);
    }
  }
}
