import 'package:dio/dio.dart';





class DioClient {
  final Dio _dio;

  DioClient({String? baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl!,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );

  Dio get dio => _dio;

  // Interceptor eklemek için örnek
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }
}