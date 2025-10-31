import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../../../core/storage/hive_providers.dart';
import '../../../core/storage/secure_storage_provider.dart';
import 'auth_api.dart';
import 'auth_repository.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthApi(dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.watch(authApiProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  final hive = ref.watch(hiveServiceProvider);
  return AuthRepository(api, secureStorage, hive);
});

