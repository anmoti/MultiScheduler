import 'package:dio/dio.dart';
import 'package:multi_scheduler/data/repositories/auth_repository.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Dio dio;
  final TokenRepository repository;

  AuthInterceptor(this.dio, this.repository);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.startsWith('/auth/')) {
      return handler.next(options);
    }

    if (!repository.isAccessTokenValid()) {
      await _refreshTokens();
    }

    final token = await repository.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  Future<void> _refreshTokens() async {
    try {
      final response = await dio.post(
        '/auth/refresh',
        data: {'refresh_token': await repository.getRefreshToken()},
      );

      final newAccess = response.data['access_token'];
      final newRefresh = response.data['refresh_token'];

      await repository.saveTokens(newAccess, newRefresh);
    } catch (e) {
      await repository.deleteTokens();

      // TODO: ログイン画面へ遷移
    }
  }
}
