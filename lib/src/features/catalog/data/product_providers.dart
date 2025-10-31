import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import 'product_api.dart';

final productApiProvider = Provider<ProductApi>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductApi(dio);
});
