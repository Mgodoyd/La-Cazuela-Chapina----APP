import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/branch_providers.dart';
import '../data/models/branch_model.dart';
import '../data/models/branch_request.dart';

class BranchListScreen extends ConsumerStatefulWidget {
  const BranchListScreen({super.key});

  @override
  ConsumerState<BranchListScreen> createState() => _BranchListScreenState();
}

class _BranchListScreenState extends ConsumerState<BranchListScreen> {
  late Future<void> _future;
  List<BranchModel> _branches = [];
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _future = _loadBranches();
    }
  }

  Future<void> _loadBranches() async {
    final repo = ref.read(branchRepositoryProvider);
    final data = await repo.fetchBranches();
    if (!mounted) return;
    setState(() => _branches = data);
  }

  Future<void> _refresh() async => _loadBranches();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sucursales'),
        actions: [
          IconButton(
            onPressed: () => context.push('/reports'),
            icon: const Icon(Icons.insights_rounded),
            tooltip: 'Reportes',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar sucursal',
        onPressed: () => _onCreate(context),
        child: const Icon(Icons.add_rounded),
      ),
      body: FutureBuilder<void>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              _branches.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError && _branches.isEmpty) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (_branches.isEmpty) {
            return const Center(
              child: Text('Aún no hay sucursales registradas'),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              itemCount: _branches.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final branch = _branches[index];
                return ListTile(
                  leading:
                      const CircleAvatar(child: Icon(Icons.store_rounded)),
                  title: Text(branch.name),
                  subtitle:
                      Text('${branch.address}\nTel: ${branch.phone}'),
                  isThreeLine: true,
                  onTap: () => _onEdit(context, branch),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          _onEdit(context, branch);
                          break;
                        case 'delete':
                          _onDelete(context, branch);
                          break;
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'edit', child: Text('Editar')),
                      PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _onCreate(BuildContext context) async {
    final request = await _showBranchForm(context, title: 'Nueva sucursal');
    if (request == null) return;

    final repo = ref.read(branchRepositoryProvider);
    try {
      await repo.createBranch(request);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sucursal creada')));
      await _refresh();
    } catch (e) {
      _showError(context, e);
    }
  }

  Future<void> _onEdit(BuildContext context, BranchModel branch) async {
    final request = await _showBranchForm(
      context,
      title: 'Editar sucursal',
      branch: branch,
    );
    if (request == null) return;

    final repo = ref.read(branchRepositoryProvider);
    try {
      await repo.updateBranch(id: branch.id, request: request);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sucursal actualizada')));
      await _refresh();
    } catch (e) {
      _showError(context, e);
    }
  }

  Future<void> _onDelete(BuildContext context, BranchModel branch) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar sucursal'),
        content: Text('¿Seguro que deseas eliminar ${branch.name}?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Eliminar')),
        ],
      ),
    );
    if (confirm != true) return;

    final repo = ref.read(branchRepositoryProvider);
    try {
      await repo.deleteBranch(branch.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sucursal eliminada')));
      await _refresh();
    } catch (e) {
      _showError(context, e);
    }
  }

  void _showError(BuildContext context, Object error) {
    var message = 'Ocurrió un error';
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        message = data['message'] as String? ?? message;
      } else if (data is String && data.isNotEmpty) {
        message = data;
      } else {
        message = error.message ?? message;
      }
    } else {
      message = error.toString();
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

// -----------------------------------------------------------------------------
// 🧩 Formulario con control seguro de TextEditingController
// -----------------------------------------------------------------------------
Future<BranchRequest?> _showBranchForm(
  BuildContext context, {
  required String title,
  BranchModel? branch,
}) async {
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController(text: branch?.name ?? '');
  final addressCtrl = TextEditingController(text: branch?.address ?? '');
  final phoneCtrl = TextEditingController(text: branch?.phone ?? '');

  final result = await showModalBottomSheet<BranchRequest>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: Theme.of(ctx).textTheme.titleMedium),
              const SizedBox(height: 16),
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Ingresa el nombre de la sucursal'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: addressCtrl,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Ingresa la dirección'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Ingresa un teléfono de contacto'
                    : null,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        Navigator.pop(
                          ctx,
                          BranchRequest(
                            name: nameCtrl.text.trim(),
                            address: addressCtrl.text.trim(),
                            phone: phoneCtrl.text.trim(),
                          ),
                        );
                      },
                      child: const Text('Guardar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  WidgetsBinding.instance.addPostFrameCallback((_) {
    nameCtrl.dispose();
    addressCtrl.dispose();
    phoneCtrl.dispose();
  });

  return result;
}
