import 'package:dio/dio.dart';
import 'package:multi_scheduler/data/repositories/auth_repository.dart';

class AuthRemoteRepository {
  final Dio _dio;
  final TokenRepository _tokenRepository;

  AuthRemoteRepository(this._dio, this._tokenRepository);

  Future<void> signup(String name, String email, String password) async {
    final response = await _dio.post(
      '/auth/signup',
      data: {'name': name, 'email': email, 'password': password},
    );

    final accessToken = response.data['access_token'];
    final refreshToken = response.data['refresh_token'];

    await _tokenRepository.saveTokens(accessToken, refreshToken);
  }

  Future<void> signin(String email, String password) async {
    final response = await _dio.post(
      '/auth/signin',
      data: {'email': email, 'password': password},
    );

    final accessToken = response.data['access_token'];
    final refreshToken = response.data['refresh_token'];

    await _tokenRepository.saveTokens(accessToken, refreshToken);
  }
}
