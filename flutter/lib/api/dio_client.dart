import 'package:dio/dio.dart';
import 'package:multi_scheduler/api/interceptors/auth_interceptor.dart';
import 'package:multi_scheduler/data/repositories/auth_repository.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:8000',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ),
);

void configureDio() {
  final tokenRepository = TokenRepository();
  dio.interceptors.add(AuthInterceptor(dio, tokenRepository));
}
