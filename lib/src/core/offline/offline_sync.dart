import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/dio_provider.dart';
import '../services/connectivity_service.dart';
import 'offline_queue.dart';
import 'offline_providers.dart';
import 'package:cazuela_chapina_app/src/core/utils/logger.dart';

class OfflineSyncService {
  OfflineSyncService(this._dio, this._queue, this._connectivity);

  final Dio _dio;
  final OfflineQueueService _queue;
  final ConnectivityService _connectivity;

  StreamSubscription<List<dynamic>>? _sub;
  bool _isSyncing = false;

  Future<void> initialize() async {
    _sub = _connectivity.onStatusChanged.listen((_) async {
      final online = await _connectivity.isOnline;
      if (online) {
        await _flush();
      }
    });
    if (await _connectivity.isOnline) {
      await _flush();
    }
  }

  Future<void> dispose() async {
    await _sub?.cancel();
  }

  Future<void> _flush() async {
    if (_isSyncing) return;
    _isSyncing = true;
    try {
      final pending = await _queue.getPending();
      
      // Primero procesar ventas sueltas, luego ventas completas
      final productPayloads = <OfflinePayload>[];
      final salePayloads = <OfflinePayload>[];
      
      for (final p in pending) {
        if (p.endpoint.contains('/product/')) {
          productPayloads.add(p);
        } else if (p.endpoint.contains('/sale')) {
          salePayloads.add(p);
        } else {
          // Otros tipos de payloads se procesan normalmente
          productPayloads.add(p);
        }
      }
      
      // Mapa para almacenar IDs temporales -> IDs reales de ventas
      final productIdMap = <String, String>{};
      
      // Procesar ventas sueltas primero
      for (final p in productPayloads) {
        try {
          String path = p.endpoint;
          final method = p.method.toUpperCase();
          Map<String, dynamic> body = Map<String, dynamic>.from(p.body);
          
          Response<dynamic> resp;
          switch (method) {
            case 'POST':
              resp = await _dio.post(path, data: body);
              break;
            case 'PUT':
              resp = await _dio.put(path, data: body);
              break;
            case 'PATCH':
              resp = await _dio.patch(path, data: body);
              break;
            case 'DELETE':
              resp = await _dio.delete(path, data: body);
              break;
            default:
              resp = await _dio.request(path, data: body, options: Options(method: method));
          }
          
          if (resp.statusCode != null && resp.statusCode! >= 200 && resp.statusCode! < 300) {
            // Si es una venta suelta, obtener el ID real de la respuesta
            if (path.contains('/product/')) {
              // El backend puede devolver el producto en resp.data['data'] o directamente en resp.data
              dynamic productData = resp.data?['data'];
              productData ??= resp.data;
              
              if (productData != null && productData is Map) {
                final productId = (productData['Id'] ?? productData['id'] ?? '').toString();
                
                // Buscar el tempProductId en el body del payload de la venta suelta
                final tempId = (p.body['tempProductId'] ?? '').toString();
                
                if (productId.isNotEmpty) {
                  if (tempId.isNotEmpty) {
                    productIdMap[tempId] = productId;
                    logDebug('Mapeado tempSaleId: $tempId -> saleId: $productId');
                  }
                  // También mapear por el ID del payload para referencia alternativa
                  productIdMap[p.id] = productId;
                  logDebug('Mapeado payloadId: ${p.id} -> saleId: $productId');
                } else {
                  logDebug('No se pudo obtener saleId de la respuesta: ${resp.data}');
                }
              }
            }
            await _queue.remove(p.id);
          }
        } catch (e) {
          logDebug('Error procesando sale: $e');
          // No removemos de la cola para reintentar luego
        }
      }
      
      // Procesar ventas después, reemplazando IDs temporales por IDs reales
      for (final p in salePayloads) {
        try {
          String path = '/sale/create';
          final method = p.method.toUpperCase();
          Map<String, dynamic> body = Map<String, dynamic>.from(p.body);
          
          final rawDate = body['Date'] ?? body['date'] ?? DateTime.now().toUtc().toIso8601String();
          final dateString = rawDate.toString();
          final normalizedDate = dateString.endsWith('Z') ? dateString : '${dateString}Z';
          
          // Reemplazar IDs temporales por IDs reales (solo para productos creados offline)
          // Los combos ya tienen el saleId real y no necesitan mapeo
          final items = <Map<String, dynamic>>[];
          for (final it in (body['Items'] ?? body['items'] ?? const [])) {
            final productId = (it['productId'] ?? it['ProductId'] ?? '').toString();
            final tempId = (it['tempProductId'] ?? '').toString();
            
            // Si tiene tempSaleId, intentar mapear al ID real
            // Si no tiene tempSaleId, es un combo y usa el saleId directamente
            final realProductId = tempId.isNotEmpty && productIdMap.containsKey(tempId)
                ? productIdMap[tempId]!
                : productId.isEmpty
                    ? tempId // Fallback al tempId si no hay saleId
                    : productId; // Usar saleId real (combos)
            
            logDebug('Procesando item: tempId=$tempId, saleId=$productId, realsaleId=$realProductId');
            
            if (realProductId.isEmpty) {
              logDebug('ERROR: No se pudo determinar saleId para el item');
              continue; 
            }
            
            items.add({
              'productId': realProductId,
              'quantity': it['Quantity'] ?? it['quantity'] ?? 1,
              'unitPrice': (it['UnitPrice'] ?? it['unitPrice'] ?? 0.0).toDouble(),
            });
          }
          
          if (items.isEmpty) {
            logDebug('ADVERTENCIA: Venta sin items válidos, saltando...');
            continue;
          }
          
          body = {
            'date': normalizedDate,
            'userId': body['UserId'] ?? body['userId'],
            'total': body['Total'] ?? body['total'],
            'items': items,
          };
          
          Response<dynamic> resp;
          switch (method) {
            case 'POST':
              resp = await _dio.post(path, data: body);
              break;
            case 'PUT':
              resp = await _dio.put(path, data: body);
              break;
            case 'PATCH':
              resp = await _dio.patch(path, data: body);
              break;
            case 'DELETE':
              resp = await _dio.delete(path, data: body);
              break;
            default:
              resp = await _dio.request(path, data: body, options: Options(method: method));
          }
          
          if (resp.statusCode != null && resp.statusCode! >= 200 && resp.statusCode! < 300) {
            await _queue.remove(p.id);
          }
        } catch (e) {
          logDebug('Error procesando venta: $e');
          break;
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> flushNow() => _flush();
}

final offlineSyncProvider = Provider<OfflineSyncService>((ref) {
  final dio = ref.watch(dioProvider);
  final queue = ref.watch(offlineQueueProvider);
  final connectivity = ref.watch(connectivityProvider);
  final service = OfflineSyncService(dio, queue, connectivity);

  service.initialize();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});


