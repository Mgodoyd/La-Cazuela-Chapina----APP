import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import 'package:cazuela_chapina_app/src/core/offline/offline_queue.dart';

import 'sale_api.dart';
import 'models/sale_model.dart';
import 'models/sale_request.dart';

class SaleQueuedException implements Exception {
  SaleQueuedException(this.message);

  final String message;

  @override
  String toString() => 'SaleQueuedException: $message';
}

class SaleRepository {
  SaleRepository(this._api, this._offlineQueue);

  final SaleApi _api;
  final OfflineQueueService _offlineQueue;
  final _uuid = const Uuid();

  Future<List<SaleModel>> fetchSales() => _api.fetchSales();

  Future<SaleModel> createSale(
    SaleRequest request, {
    bool queueOnError = true,
  }) async {
    try {
      return await _api.createSale(request);
    } on DioException {
      if (!queueOnError) rethrow;

      final payload = OfflinePayload(
        id: _uuid.v4(),
        endpoint: '/sale/create',
        method: 'POST',
        body: request.toJson(),
        createdAt: DateTime.now(),
      );
      await _offlineQueue.enqueue(payload);
      throw SaleQueuedException(
        'Venta guardada offline. Se sincronizará cuando haya conexión.',
      );
    }
  }

  Future<List<OfflinePayload>> getPendingSales() => _offlineQueue.getPending();

  Future<void> markSaleAsSynced(String payloadId) =>
      _offlineQueue.remove(payloadId);
}

