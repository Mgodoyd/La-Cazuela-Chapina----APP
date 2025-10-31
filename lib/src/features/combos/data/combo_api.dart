import 'package:dio/dio.dart';

import 'models/combo_model.dart';
import 'models/create_combo_request.dart';

class ComboApi {
  ComboApi(this._dio);

  final Dio _dio;

  Future<List<ComboModel>> fetchCombos() async {
    final response = await _dio.get<Map<String, dynamic>>('/combos');
    final data = response.data?['data'] as List<dynamic>? ?? const [];

    return data
        .map((item) => ComboModel.fromJson(
            Map<String, dynamic>.from(item as Map<dynamic, dynamic>)))
        .toList();
  }

  Future<ComboModel> createCombo(CreateComboRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/combos/create',
      data: request.toJson(),
    );
    final data = response.data?['data'] ?? response.data;
    return ComboModel.fromJson(
      Map<String, dynamic>.from(data as Map<dynamic, dynamic>),
    );
  }
}

