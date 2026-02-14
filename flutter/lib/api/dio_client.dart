import 'package:dio/dio.dart';
import 'package:multi_scheduler/api/generated/multi_scheduler_client.dart';
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
  dio.interceptors.clear();
  final tokenRepository = TokenRepository();
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    ),
  );
  dio.interceptors.add(AuthInterceptor(dio, tokenRepository));
}

final client = MultiSchedulerClient(dio);
