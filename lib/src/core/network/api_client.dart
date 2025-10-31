import 'package:dio/dio.dart';

class ApiClient {
  ApiClient({
    required String baseUrl,
    List<Interceptor>? interceptors,
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 15),
          ),
        )..interceptors.addAll(interceptors ?? const []);

  final Dio _dio;

  Dio get dio => _dio;
}

