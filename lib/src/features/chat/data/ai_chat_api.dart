import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';

class AiChatApi {
  AiChatApi(this._dio);

  final Dio _dio;

  Future<String> sendMessage({required String message}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/ai/chat',
      data: {'message': message},
    );

    final data = response.data;
    if (data == null) {
      throw StateError('Respuesta vacia del asistente.');
    }

    final possibleKeys = [
      'reply',
      'message',
      'response',
      'data',
      'result',
    ];
    for (final key in possibleKeys) {
      final value = data[key];
      if (value is String && value.trim().isNotEmpty) {
        return value;
      }
      if (value is Map<String, dynamic>) {
        final nested = value['message'] ?? value['text'];
        if (nested is String && nested.trim().isNotEmpty) {
          return nested;
        }
      }
    }

    return data.toString();
  }
}

final aiChatApiProvider = Provider<AiChatApi>((ref) {
  final dio = ref.watch(dioProvider);
  return AiChatApi(dio);
});
