import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import 'branch_api.dart';
import 'branch_repository.dart';

final branchApiProvider = Provider<BranchApi>((ref) {
  final dio = ref.watch(dioProvider);
  return BranchApi(dio);
});

final branchRepositoryProvider = Provider<BranchRepository>((ref) {
  final api = ref.watch(branchApiProvider);
  return BranchRepository(api);
});
