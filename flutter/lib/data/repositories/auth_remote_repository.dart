import 'package:multi_scheduler/api/generated/models/user_create.dart';
import 'package:multi_scheduler/api/generated/models/user_login.dart';
import 'package:multi_scheduler/api/generated/multi_scheduler_client.dart';
import 'package:multi_scheduler/data/repositories/auth_repository.dart';

class AuthRemoteRepository {
  final MultiSchedulerClient _client;
  final TokenRepository _tokenRepository;

  AuthRemoteRepository(this._client, this._tokenRepository);

  Future<void> signup(String name, String email, String password) async {
    final response = await _client.fallback.signupUserAuthSignupPost(
      body: UserCreate(name: name, email: email, password: password),
    );

    final accessToken = response.accessToken;
    final refreshToken = response.refreshToken;

    await _tokenRepository.saveTokens(accessToken, refreshToken);
  }

  Future<void> signin(String email, String password) async {
    final response = await _client.fallback.signinUserAuthSigninPost(
      body: UserLogin(email: email, password: password),
    );

    final accessToken = response.accessToken;
    final refreshToken = response.refreshToken;

    await _tokenRepository.saveTokens(accessToken, refreshToken);
  }
}
