import "package:cazuela_chapina_app/src/features/branches/data/branch_providers.dart";
import "package:cazuela_chapina_app/src/features/branches/data/branch_repository.dart";
import "package:cazuela_chapina_app/src/features/branches/data/branch_api.dart";
import "package:cazuela_chapina_app/src/features/branches/data/models/branch_model.dart";
import "package:cazuela_chapina_app/src/features/branches/data/models/branch_request.dart";
import "package:cazuela_chapina_app/src/features/branches/presentation/branch_list_screen.dart";
import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";

class _FakeBranchRepository extends BranchRepository {
  _FakeBranchRepository() : super(BranchApi(Dio()));

  final List<BranchModel> _branches = <BranchModel>[
    const BranchModel(
      id: '1',
      name: 'Sucursal Centro',
      address: 'Av. Central 123',
      phone: '555-0001',
    ),
  ];

  @override
  Future<List<BranchModel>> fetchBranches() async => List<BranchModel>.from(_branches);

  @override
  Future<BranchModel> createBranch(BranchRequest request) async {
    final branch = BranchModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: request.name,
      address: request.address,
      phone: request.phone,
    );
    _branches.add(branch);
    return branch;
  }

  @override
  Future<void> updateBranch({required String id, required BranchRequest request}) async {
    final index = _branches.indexWhere((branch) => branch.id == id);
    if (index == -1) return;
    _branches[index] = BranchModel(
      id: id,
      name: request.name,
      address: request.address,
      phone: request.phone,
    );
  }

  @override
  Future<void> deleteBranch(String id) async {
    _branches.removeWhere((branch) => branch.id == id);
  }
}

void main() {
  testWidgets('BranchListScreen renders without crashes', (tester) async {
    final repository = _FakeBranchRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          branchRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(
          home: BranchListScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Sucursal Centro'), findsOneWidget);
  });
}
