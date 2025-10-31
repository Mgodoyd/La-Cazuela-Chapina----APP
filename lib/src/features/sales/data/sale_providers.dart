import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../../../core/offline/offline_providers.dart';
import 'sale_api.dart';
import 'sale_repository.dart';

final saleApiProvider = Provider<SaleApi>((ref) {
  final dio = ref.watch(dioProvider);
  return SaleApi(dio);
});

final saleRepositoryProvider = Provider<SaleRepository>((ref) {
  final api = ref.watch(saleApiProvider);
  final offlineQueue = ref.watch(offlineQueueProvider);
  return SaleRepository(api, offlineQueue);
});

