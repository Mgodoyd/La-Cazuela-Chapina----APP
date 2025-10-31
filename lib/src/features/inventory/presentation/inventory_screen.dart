import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/inventory_providers.dart';
import '../data/models/inventory_item_model.dart';
import '../data/models/inventory_movement_model.dart';
import '../data/models/raw_material_request.dart';
import '../../../core/notifications/notification_providers.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  late Future<void> _future;
  List<InventoryItemModel> _items = [];
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _future = _loadInventory();
    }
  }

  Future<void> _loadInventory() async {
    final repository = ref.read(inventoryRepositoryProvider);
    final data = await repository.fetchInventory();
    if (!mounted) return;
    setState(() => _items = data);
  }

  Future<void> _refresh() async => _loadInventory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventario')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar materia prima',
        onPressed: () => _openRawMaterialDialog(context),
        child: const Icon(Icons.add_rounded),
      ),
      body: FutureBuilder<void>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              _items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError && _items.isEmpty) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (_items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Aún no hay materias primas registradas'),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () => _openRawMaterialDialog(context),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Crear materia prima'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              itemCount: _items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = _items[index];
                final lowStock =
                    item.currentQuantity < item.rawMaterial.minStock;
                final colorScheme = Theme.of(context).colorScheme;

                return ListTile(
                  tileColor: lowStock
                      ? colorScheme.errorContainer.withValues(alpha: 0.12)
                      : null,
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.rawMaterial.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (lowStock)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Stock bajo',
                            style: TextStyle(
                              color: colorScheme.onErrorContainer,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Actual: ${item.currentQuantity.toStringAsFixed(2)} ${item.rawMaterial.unit}',
                        ),
                        Text(
                          'Mínimo: ${item.rawMaterial.minStock.toStringAsFixed(2)} ${item.rawMaterial.unit}',
                          style: TextStyle(
                            color: lowStock
                                ? colorScheme.error
                                : Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: 'Registrar movimiento',
                        icon: const Icon(Icons.add_circle_outline_rounded),
                        onPressed: () => _openMovementDialog(context, item),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              _openEditRawMaterialDialog(context, item);
                              break;
                            case 'delete':
                              _confirmDeleteRawMaterial(context, item);
                              break;
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 'edit', child: Text('Editar')),
                          PopupMenuItem(
                              value: 'delete', child: Text('Eliminar')),
                        ],
                      ),
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

  // Movimiento de inventario

  Future<void> _openMovementDialog(
      BuildContext context, InventoryItemModel item) async {
    final qtyCtrl = TextEditingController();
    final reasonCtrl = TextEditingController();
    final costCtrl = TextEditingController();
    var movementType = 'IN';

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Registrar movimiento - ${item.rawMaterial.name}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: movementType,
                  items: const [
                    DropdownMenuItem(value: 'IN', child: Text('Entrada')),
                    DropdownMenuItem(value: 'OUT', child: Text('Salida')),
                    DropdownMenuItem(value: 'WASTE', child: Text('Merma')),
                  ],
                  onChanged: (v) => movementType = v ?? 'IN',
                  decoration: const InputDecoration(labelText: 'Tipo'),
                ),
                TextField(
                  controller: qtyCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Cantidad'),
                ),
                TextField(
                  controller: costCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      const InputDecoration(labelText: 'Costo (opcional)'),
                ),
                TextField(
                  controller: reasonCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Motivo (opcional)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () async {
                final qty = double.tryParse(qtyCtrl.text.trim()) ?? 0;
                if (qty <= 0) {
                  _showError(dialogContext, 'Ingresa una cantidad válida');
                  return;
                }

                final repo = ref.read(inventoryRepositoryProvider);
                final movement = InventoryMovementModel(
                  type: movementType,
                  quantity: qty,
                  cost: double.tryParse(costCtrl.text.trim()),
                  reason: reasonCtrl.text.trim().isEmpty
                      ? null
                      : reasonCtrl.text.trim(),
                );

                try {
                  await repo.registerMovement(
                    rawMaterialId: item.rawMaterial.id ?? '',
                    movement: movement,
                  );
                  if (!dialogContext.mounted) return;
                  Navigator.pop(dialogContext);
                  _showSnack(dialogContext, 'Movimiento registrado');
                  await _refresh();
                } on DioException catch (e) {
                  if (!dialogContext.mounted) return;
                  _showError(dialogContext, e);
                } catch (e) {
                  if (!dialogContext.mounted) return;
                  _showError(dialogContext, e);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );

    // Libera controladores después del frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      qtyCtrl.dispose();
      reasonCtrl.dispose();
      costCtrl.dispose();
    });
  }

  // Crear materia prima
  Future<void> _openRawMaterialDialog(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final unitCtrl = TextEditingController(text: 'kg');
    final minStockCtrl = TextEditingController(text: '0');

    final request = await showModalBottomSheet<RawMaterialRequest>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Nueva materia prima',
                    style: Theme.of(sheetContext).textTheme.titleMedium),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Ingresa un nombre' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: unitCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Unidad (kg, l, unidad, etc.)'),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Ingresa la unidad de medida'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: minStockCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      const InputDecoration(labelText: 'Stock mínimo'),
                  validator: (v) {
                    final parsed = double.tryParse(v?.trim() ?? '');
                    if (parsed == null || parsed < 0) {
                      return 'Ingresa un número válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        child: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          Navigator.pop(
                            sheetContext,
                            RawMaterialRequest(
                              name: nameCtrl.text.trim(),
                              unit: unitCtrl.text.trim(),
                              minStock:
                                  double.parse(minStockCtrl.text.trim()),
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
      unitCtrl.dispose();
      minStockCtrl.dispose();
    });

    if (request == null) return;

    final repo = ref.read(inventoryRepositoryProvider);
    try {
      await repo.createRawMaterial(request);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Materia prima creada')),
      );
      await _refresh();

      try {
        final notif = ref.read(notificationServiceProvider);
        await notif.init();
        await notif.showNotification(
          title: 'Inventario actualizado',
          body: 'Materia prima ${request.name} creada exitosamente',
        );
      } catch (_) {}
    } on DioException catch (e) {
      if (!mounted) return;
      _showError(context, e);
    } catch (e) {
      if (!mounted) return;
      _showError(context, e);
    }
  }

  // Editar materia prima
  Future<void> _openEditRawMaterialDialog(
      BuildContext context, InventoryItemModel item) async {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController(text: item.rawMaterial.name);
    final unitCtrl = TextEditingController(text: item.rawMaterial.unit);
    final minStockCtrl =
        TextEditingController(text: item.rawMaterial.minStock.toStringAsFixed(2));

    final request = await showModalBottomSheet<RawMaterialRequest>(
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
                Text('Editar materia prima',
                    style: Theme.of(ctx).textTheme.titleMedium),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Ingresa un nombre' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: unitCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Unidad (kg, l, unidad, etc.)'),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Ingresa la unidad de medida'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: minStockCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      const InputDecoration(labelText: 'Stock mínimo'),
                  validator: (v) {
                    final parsed = double.tryParse(v?.trim() ?? '');
                    if (parsed == null || parsed < 0) {
                      return 'Ingresa un número válido';
                    }
                    return null;
                  },
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
                            RawMaterialRequest(
                              name: nameCtrl.text.trim(),
                              unit: unitCtrl.text.trim(),
                              minStock:
                                  double.parse(minStockCtrl.text.trim()),
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
      unitCtrl.dispose();
      minStockCtrl.dispose();
    });

    if (request == null) return;

    final repo = ref.read(inventoryRepositoryProvider);
    try {
      await repo.updateRawMaterial(
        rawMaterialId: item.rawMaterial.id ?? '',
        request: request,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Materia prima actualizada')));
      await _refresh();
    } on DioException catch (e) {
      if (!mounted) return;
      _showError(context, e);
    } catch (e) {
      if (!mounted) return;
      _showError(context, e);
    }
  }

  // Eliminar materia prima
  Future<void> _confirmDeleteRawMaterial(
      BuildContext context, InventoryItemModel item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar materia prima'),
        content:
            Text('¿Seguro que deseas eliminar ${item.rawMaterial.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    final repo = ref.read(inventoryRepositoryProvider);
    try {
      await repo.deleteRawMaterial(item.rawMaterial.id ?? '');
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Materia prima eliminada')));
      await _refresh();

      try {
        final notif = ref.read(notificationServiceProvider);
        await notif.init();
        await notif.showNotification(
          title: 'Inventario actualizado',
          body: 'Materia prima ${item.rawMaterial.name} eliminada',
        );
      } catch (_) {}
    } on DioException catch (e) {
      if (!mounted) return;
      _showError(context, e);
    } catch (e) {
      if (!mounted) return;
      _showError(context, e);
    }
  }

  // -------------------------------------------------------------------------
  // 🔹 Utilidades
  // -------------------------------------------------------------------------
  void _showSnack(BuildContext context, String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

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
    } else if (error is String) {
      message = error;
    } else if (error is Exception) {
      message = error.toString();
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
