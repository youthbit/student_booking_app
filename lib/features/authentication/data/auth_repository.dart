// ignore_for_file: only_throw_errors
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/constants.dart';
import '../../../config/utils.dart';
import '../../../exceptions/app_exception.dart';
import '../../../main.dart';
import '../domain/login_creds.dart';
import '../domain/user.dart';
import 'auth_utils.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final bool addDelay;
  final Dio _dio = getIt<Dio>();
  final _authState = InMemoryStore<User?>(null);

  User? get currentUser => _authState.value;

  AuthRepository({this.addDelay = true});

  Stream<User?> authStateChanges() => _authState.stream;

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await delay(addDelay: addDelay);

    final Response<ResponseJson> resToken;
    try {
      resToken = await _dio.post<ResponseJson>(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw const AppException.userNotFound();
      }

      throw const AppException.userNotFound();
    }

    final token = Creds.fromJson(resToken.data!);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.tokenPref, token.token);
    return retrieveUserData(token.token);
  }

  Future<User> retrieveUserData(String token) async {
    final opt = Options(
      headers: <String, dynamic>{
        'Authorization': 'Bearer $token',
      },
    );
    late final Response<ResponseJson> response;
    try {
      response = await _dio.get<ResponseJson>('/auth/me', options: opt);
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw const AppException.userNotFound();
      }

      throw const AppException.userNotFound();
    }
    if (response.data == null) {
      throw const AppException.userNotFound();
    }
    final userParams = Map<String, dynamic>.of(response.data!);
    userParams['token'] = token;
    userParams['runtimeType'] = 'User';
    final user = User.fromJson(userParams);
    _authState.value = user;
    return user;
  }

  Future<User> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await delay(addDelay: addDelay);
    final Response<ResponseJson> response;
    try {
      response = await _dio.post<ResponseJson>(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
        },
      );
    } on DioError {
      throw const AppException.userNotFound();
    }
    if (response.data == null) {
      throw const AppException.userNotFound();
    }
    final creds = Creds.fromJson(response.data!);
    return retrieveUserData(creds.token);
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.tokenPref);
    _authState.value = null;
  }

  Future<void> restoreUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get(Constants.tokenPref);
    if (token == null) {
      return;
    }

    _authState.value = await retrieveUserData(token.toString());
  }

  void dispose() => _authState.close();
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final auth = AuthRepository()..restoreUserData();
  ref.onDispose(auth.dispose);
  return auth;
}

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
