import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import 'inventory_api.dart';
import 'inventory_repository.dart';

final inventoryApiProvider = Provider<InventoryApi>((ref) {
  final dio = ref.watch(dioProvider);
  return InventoryApi(dio);
});

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  final api = ref.watch(inventoryApiProvider);
  return InventoryRepository(api);
});
