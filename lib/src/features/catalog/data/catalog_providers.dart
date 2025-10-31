import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'product_providers.dart';
import 'catalog_repository.dart';

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  final api = ref.watch(productApiProvider);
  return CatalogRepository(api);
});

