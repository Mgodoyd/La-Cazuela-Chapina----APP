
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import 'combo_api.dart';
import 'combos_repository.dart';

final comboApiProvider = Provider<ComboApi>((ref) {
  final dio = ref.watch(dioProvider);
  return ComboApi(dio);
});

final combosRepositoryProvider = Provider<CombosRepository>((ref) {
  final api = ref.watch(comboApiProvider);
  return CombosRepository(api);
});

