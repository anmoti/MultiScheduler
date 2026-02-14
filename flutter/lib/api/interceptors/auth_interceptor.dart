import 'package:dio/dio.dart';
import 'package:multi_scheduler/data/repositories/auth_repository.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Dio dio;
  final TokenRepository repository;
  late final Dio _refreshDio;

  AuthInterceptor(this.dio, this.repository) {
    _refreshDio = Dio(BaseOptions(baseUrl: dio.options.baseUrl));
  }

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
      final refreshToken = await repository.getRefreshToken();
      if (refreshToken == null) return;

      final response = await _refreshDio.post(
        '/auth/refresh',
        options: Options(headers: {'X-Refresh-Token': refreshToken}),
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
