import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/order_providers.dart';
import '../data/models/order_model.dart';
import '../data/models/order_request.dart';
import '../../../core/notifications/notification_providers.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  late Future<void> _future;
  List<OrderModel> _orders = <OrderModel>[];
  String _filter = 'all'; // all | today | month
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _future = _loadOrders();
    }
  }

  Future<void> _loadOrders() async {
    final api = ref.read(orderApiProvider);
    final orders = await api.fetchOrders();
    if (!mounted) return;
    setState(() => _orders = orders);
  }

  Future<void> _refresh() async {
    await _loadOrders();
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Órdenes'),
        actions: [
          PopupMenuButton<String>(
            initialValue: _filter,
            onSelected: (v) => setState(() => _filter = v),
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'all', child: Text('Todas')),
              PopupMenuItem(value: 'today', child: Text('Hoy')),
              PopupMenuItem(value: 'month', child: Text('Este mes')),
            ],
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              _orders.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError && _orders.isEmpty) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final now = DateTime.now();
          bool filter(OrderModel o) {
            return _filter == 'all' ||
                (_filter == 'today' && _sameDay(o.createdAt, now)) ||
                (_filter == 'month' &&
                    o.createdAt.year == now.year &&
                    o.createdAt.month == now.month);
          }

          final filtered = _orders.where(filter).toList();

          if (filtered.isEmpty) {
            return const Center(child: Text('No hay órdenes'));
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final o = filtered[i];
                final total = o.items.fold<double>(
                    0, (p, it) => p + it.unitPrice * it.quantity);

                return ListTile(
                  title: Text(
                      'Orden ${o.id.substring(0, 6)} • Q${total.toStringAsFixed(2)}'),
                  subtitle: Text(
                      '${o.createdAt.toString().substring(0, 16)} • ${o.status}'),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      switch (value) {
                        case 'edit':
                          await _onEdit(context, o);
                          break;
                        case 'delete':
                          await _onDelete(context, o);
                          break;
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'edit', child: Text('Editar')),
                      PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                    ],
                  ),
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (_) => _OrderDetailSheet(order: o),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _onEdit(BuildContext context, OrderModel order) async {
    final request =
        await _showOrderForm(context, title: 'Editar orden', order: order);
    if (request == null) return;

    try {
      final api = ref.read(orderApiProvider);
      await api.updateOrder(id: order.id, request: request);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Orden actualizada')));
      await _refresh();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error al actualizar: $e')));
    }
  }

  Future<void> _onDelete(BuildContext context, OrderModel order) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar orden'),
        content:
            Text('¿Seguro que deseas eliminar la orden ${order.id.substring(0, 6)}?'),
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

    try {
      final api = ref.read(orderApiProvider);
      await api.deleteOrder(order.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Orden eliminada')));
      await _refresh();
      try {
        final notif = ref.read(notificationServiceProvider);
        await notif.init();
        await notif.showNotification(
          title: 'Orden eliminada',
          body: 'La orden ${order.id.substring(0, 6)} ha sido eliminada',
        );
      } catch (_) {}
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error al eliminar: $e')));
    }
  }
}

Future<OrderRequest?> _showOrderForm(
  BuildContext context, {
  required String title,
  OrderModel? order,
}) async {
  final statusCtrl = TextEditingController(text: order?.status ?? 'pending');
  final confirmed = ValueNotifier<bool>(order?.confirmed ?? false);

  final form = await showModalBottomSheet<OrderRequest>(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(ctx).textTheme.titleMedium),
            const SizedBox(height: 16),
            TextField(
              controller: statusCtrl,
              decoration: const InputDecoration(labelText: 'Estado'),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<bool>(
              valueListenable: confirmed,
              builder: (ctx, value, _) => SwitchListTile(
                title: const Text('Confirmada'),
                value: value,
                onChanged: (v) => confirmed.value = v,
              ),
            ),
            const SizedBox(height: 16),
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
                      Navigator.pop(
                        ctx,
                        OrderRequest(
                          userId: order?.userId ?? '',
                          status: statusCtrl.text.trim(),
                          confirmed: confirmed.value,
                          stock: order?.stock ?? 0,
                          items: [
                            for (final it in order?.items ?? const [])
                              OrderItemRequest(
                                productId: it.productId,
                                quantity: it.quantity,
                                unitPrice: it.unitPrice,
                              )
                          ],
                          createdAt: order?.createdAt,
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
      );
    },
  );

  // Libera controladores después del frame
  WidgetsBinding.instance.addPostFrameCallback((_) {
    statusCtrl.dispose();
    confirmed.dispose();
  });

  return form;
}

class _OrderDetailSheet extends StatelessWidget {
  const _OrderDetailSheet({required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final total = order.items
        .fold<double>(0, (p, it) => p + it.unitPrice * it.quantity);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Detalle de orden',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final it in order.items)
            ListTile(
              dense: true,
              title: Text(it.product?.name ?? it.productId),
              subtitle: Text('x${it.quantity} • Q${it.unitPrice.toStringAsFixed(2)}'),
            ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Total: Q${total.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
