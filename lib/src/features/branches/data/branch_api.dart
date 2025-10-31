import 'package:dio/dio.dart';

import 'models/branch_model.dart';
import 'models/branch_request.dart';

class BranchApi {
  BranchApi(this._dio);
  final Dio _dio;

  Future<List<BranchModel>> fetchBranches() async {
    final resp = await _dio.get<Map<String, dynamic>>('/branch');
    final list = resp.data?['data'] as List<dynamic>? ?? [];
    return list
        .map(
          (e) => BranchModel.fromJson(
            Map<String, dynamic>.from(e as Map<dynamic, dynamic>),
          ),
        )
        .toList();
  }

  Future<BranchModel> createBranch(BranchRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/branch/create',
      data: request.toJson(),
    );
    final data = Map<String, dynamic>.from(
      (response.data?['data'] ?? {}) as Map<dynamic, dynamic>,
    );
    return BranchModel.fromJson(data);
  }

  Future<void> updateBranch({
    required String id,
    required BranchRequest request,
  }) async {
    await _dio.put<void>('/branch/$id', data: request.toJson());
  }

  Future<void> deleteBranch(String id) async {
    await _dio.delete<void>('/branch/$id');
  }
}
