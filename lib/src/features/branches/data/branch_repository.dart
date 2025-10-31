import 'branch_api.dart';
import 'models/branch_model.dart';
import 'models/branch_request.dart';

class BranchRepository {
  BranchRepository(this._api);

  final BranchApi _api;

  Future<List<BranchModel>> fetchBranches() => _api.fetchBranches();

  Future<BranchModel> createBranch(BranchRequest request) =>
      _api.createBranch(request);

  Future<void> updateBranch({
    required String id,
    required BranchRequest request,
  }) => _api.updateBranch(id: id, request: request);

  Future<void> deleteBranch(String id) => _api.deleteBranch(id);
}
