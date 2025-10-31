import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import 'supplier_api.dart';
import 'supplier_repository.dart';

final supplierApiProvider = Provider<SupplierApi>((ref) {
  final dio = ref.watch(dioProvider);
  return SupplierApi(dio);
});

final supplierRepositoryProvider = Provider<SupplierRepository>((ref) {
  final api = ref.watch(supplierApiProvider);
  return SupplierRepository(api);
});
