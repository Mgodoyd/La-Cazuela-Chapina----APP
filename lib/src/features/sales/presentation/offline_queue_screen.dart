import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/offline/offline_providers.dart';
import '../../../core/offline/offline_queue.dart';
import '../../../core/offline/offline_sync.dart';
import 'package:cazuela_chapina_app/src/core/utils/logger.dart';

final _pendingProvider = FutureProvider<List<OfflinePayload>>((ref) async {
  final queue = ref.watch(offlineQueueProvider);
  
  return queue.getPending();
});

class OfflineQueueScreen extends ConsumerStatefulWidget {
  const OfflineQueueScreen({super.key});

  @override
  ConsumerState<OfflineQueueScreen> createState() => _OfflineQueueScreenState();
}

class _OfflineQueueScreenState extends ConsumerState<OfflineQueueScreen> {
  bool _hasInitialized = false;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(_pendingProvider);
    
    // Invalidar el provider al entrar por primera vez
    if (!_hasInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => _hasInitialized = true);
          ref.invalidate(_pendingProvider);
        }
      });
    }
    
    // Debug: verificar datos cuando hay información
    async.whenData((items) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        logDebug('queue:  [33m${items.length} [0m items pendientes');
        for (var item in items) {
          final body = item.body;
          logDebug('queue item:  [36m${item.method} [0m ${item.endpoint}');
          logDebug('queue body keys: ${body.keys.toList()}');
          if (body.containsKey('items')) {
            final itemsList = body['items'];
            if (itemsList is List) {
              logDebug('queue items count: ${itemsList.length}');
            }
          }
        }
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas offline (cola)'),
        actions: [
          IconButton(
            tooltip: 'Limpiar cola',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Limpiar cola'),
                  content: const Text('¿Seguro que deseas eliminar todas las ventas pendientes?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancelar'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Eliminar todas'),
                    ),
                  ],
                ),
              );
              if (confirm != true) return;
              final queue = ref.read(offlineQueueProvider);
              final items = await queue.getPending();
              for (final item in items) {
                await queue.remove(item.id);
              }
              if (mounted) {
                ref.invalidate(_pendingProvider);
              }
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cola limpiada')),
                );
              }
            },
            icon: const Icon(Icons.clear_all_rounded),
          ),
          IconButton(
            tooltip: 'Sincronizar ahora',
            onPressed: () async {
              await ref.read(offlineSyncProvider).flushNow();
              if (mounted) {
                ref.invalidate(_pendingProvider);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sincronización ejecutada')),
                );
              }
            },
            icon: const Icon(Icons.sync_rounded),
          ),
        ],
      ),
      body: async.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No hay ventas pendientes'));
          }
          final list = ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final p = items[i];
              final body = p.body as Map<String, dynamic>? ?? {};
              final itemsList = body['items'] as List<dynamic>? ?? [];
              final total = body['total'] ?? 0.0;
              final isSale = p.endpoint.contains('/sale');
              final isProduct = p.endpoint.contains('/product/');
              
              return ExpansionTile(
                leading: Icon(
                  isSale ? Icons.shopping_cart_outlined 
                         : isProduct ? Icons.inventory_2_outlined 
                         : Icons.offline_pin_outlined,
                ),
                title: Text(
                  isSale 
                    ? 'Venta - Q${total.toStringAsFixed(2)}'
                    : isProduct 
                      ? 'Producto: ${body['name'] ?? 'N/A'}'
                      : '${p.method} ${p.endpoint}',
                ),
                subtitle: Text('Creado: ${p.createdAt.toString().split('.')[0]}'),
                trailing: IconButton(
                  tooltip: 'Eliminar de cola',
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () async {
                    await ref.read(offlineQueueProvider).remove(p.id);
                    if (mounted) {
                      ref.invalidate(_pendingProvider);
                    }
                  },
                ),
                children: isSale && itemsList.isNotEmpty
                    ? [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Items:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              ...itemsList.map((item) {
                                final qty = item['quantity'] ?? item['Quantity'] ?? 1;
                                final price = item['unitPrice'] ?? item['UnitPrice'] ?? 0.0;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    '• x$qty - Q${(price * qty).toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ]
                    : [],
              );
            },
          );
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(_pendingProvider);
              await Future<void>.delayed(const Duration(milliseconds: 200));
            },
            child: list,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}


