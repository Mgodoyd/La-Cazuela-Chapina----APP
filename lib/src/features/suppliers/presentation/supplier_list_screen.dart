import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/supplier_model.dart';
import '../data/models/supplier_request.dart';
import '../data/supplier_providers.dart';
import '../../../core/notifications/notification_providers.dart';

class SupplierListScreen extends ConsumerStatefulWidget {
  const SupplierListScreen({super.key});

  @override
  ConsumerState<SupplierListScreen> createState() => _SupplierListScreenState();
}

class _SupplierListScreenState extends ConsumerState<SupplierListScreen> {
  late Future<void> _future;
  List<SupplierModel> _suppliers = [];

  @override
  void initState() {
    super.initState();
    _future = _loadSuppliers();
  }

  Future<void> _loadSuppliers() async {
    final repo = ref.read(supplierRepositoryProvider);
    final data = await repo.fetchSuppliers();
    if (!mounted) return;
    setState(() => _suppliers = data);
  }

  Future<void> _refresh() async {
    await _loadSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Proveedores')),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar proveedor',
        onPressed: _onCreate,
        child: const Icon(Icons.add_business_rounded),
      ),
      body: FutureBuilder<void>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              _suppliers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError && _suppliers.isEmpty) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (_suppliers.isEmpty) {
            return const Center(
              child: Text('Aún no hay proveedores registrados'),
            );
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _suppliers.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final supplier = _suppliers[index];
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.delivery_dining_rounded),
                  ),
                  title: Text(supplier.name),
                  subtitle:
                      Text('${supplier.contact}\nTel: ${supplier.phone}'),
                  isThreeLine: true,
                  onTap: () => _onEdit(supplier),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          _onEdit(supplier);
                          break;
                        case 'delete':
                          _onDelete(supplier);
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

  Future<void> _onCreate() async {
    final request = await _showSupplierForm(context, title: 'Nuevo proveedor');
    if (request == null) return;
    final repo = ref.read(supplierRepositoryProvider);
    try {
      await repo.createSupplier(request);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proveedor creado')),
      );
      await _refresh();
      try {
        final notif = ref.read(notificationServiceProvider);
        await notif.init();
        await notif.showNotification(
          title: 'Proveedor agregado',
          body: '${request.name} ha sido registrado exitosamente',
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

  Future<void> _onEdit(SupplierModel supplier) async {
    final request = await _showSupplierForm(
      context,
      title: 'Editar proveedor',
      supplier: supplier,
    );
    if (request == null) return;
    final repo = ref.read(supplierRepositoryProvider);
    try {
      await repo.updateSupplier(id: supplier.id, request: request);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proveedor actualizado')),
      );
      await _refresh();
    } on DioException catch (e) {
      if (!mounted) return;
      _showError(context, e);
    } catch (e) {
      if (!mounted) return;
      _showError(context, e);
    }
  }

  Future<void> _onDelete(SupplierModel supplier) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar proveedor'),
        content: Text('¿Seguro que deseas eliminar ${supplier.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    final repo = ref.read(supplierRepositoryProvider);
    try {
      await repo.deleteSupplier(supplier.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proveedor eliminado')),
      );
      await _refresh();
      try {
        final notif = ref.read(notificationServiceProvider);
        await notif.init();
        await notif.showNotification(
          title: 'Proveedor eliminado',
          body: '${supplier.name} ha sido eliminado',
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
    } else if (error is Exception) {
      message = error.toString();
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

Future<SupplierRequest?> _showSupplierForm(
  BuildContext context, {
  required String title,
  SupplierModel? supplier,
}) async {
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController(text: supplier?.name ?? '');
  final contactCtrl = TextEditingController(text: supplier?.contact ?? '');
  final phoneCtrl = TextEditingController(text: supplier?.phone ?? '');

  final request = await showModalBottomSheet<SupplierRequest>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              TextFormField(
                controller: nameCtrl,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Nombre comercial'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa el nombre del proveedor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: contactCtrl,
                textCapitalization: TextCapitalization.words,
                decoration:
                    const InputDecoration(labelText: 'Persona de contacto'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa el contacto principal';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa un teléfono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        Navigator.pop(
                          context,
                          SupplierRequest(
                            name: nameCtrl.text.trim(),
                            contact: contactCtrl.text.trim(),
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

  // Destruir controladores después del frame
  WidgetsBinding.instance.addPostFrameCallback((_) {
    nameCtrl.dispose();
    contactCtrl.dispose();
    phoneCtrl.dispose();
  });

  return request;
}
