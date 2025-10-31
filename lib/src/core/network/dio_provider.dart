import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/app_config_provider.dart';
import '../storage/secure_storage_provider.dart';
import 'api_client.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);

  final secureStorage = ref.watch(secureStorageProvider);

  final interceptors = <Interceptor>[
    AuthInterceptor(secureStorage),
    ErrorInterceptor(),
  ];

  if (kDebugMode) {
    interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: false,
      ),
    );
  }

  return ApiClient(
    baseUrl: config.apiBaseUrl,
    interceptors: interceptors,
  ).dio;
});

