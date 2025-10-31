import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import 'order_api.dart';
import 'order_repository.dart';

final orderApiProvider = Provider<OrderApi>((ref) {
  final dio = ref.watch(dioProvider);
  return OrderApi(dio);
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final api = ref.watch(orderApiProvider);
  return OrderRepository(api);
});

