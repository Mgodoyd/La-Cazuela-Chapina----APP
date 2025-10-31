import 'package:dio/dio.dart';

import '../../utils/logger.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logError(err, err.stackTrace);
    super.onError(err, handler);
  }
}

