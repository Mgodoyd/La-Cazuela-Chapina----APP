import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../orders/data/order_providers.dart';
import '../../auth/presentation/controllers/auth_controller.dart';
import '../../auth/data/auth_providers.dart';
import '../../orders/data/models/order_model.dart';
import '../../chat/presentation/ai_assistant_bubble.dart';

final _ordersProvider = FutureProvider.autoDispose((ref) async {
  final api = ref.watch(orderApiProvider);
  return api.fetchOrders();
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final ordersAsync = ref.watch(_ordersProvider);

    final items = <_DashItem>[
      _DashItem(
        'Ventas offline',
        Icons.point_of_sale_rounded,
        '/sales/offline',
      ),
      _DashItem(
        'Ventas online',
        Icons.cloud_done_rounded,
        '/sales/online',
      ),
      _DashItem('Inventario', Icons.inventory_2_rounded, '/inventory'),
      _DashItem('Ordenes', Icons.receipt_long_rounded, '/orders'),
      _DashItem('Proveedores', Icons.local_shipping_rounded, '/suppliers'),
      _DashItem('Sucursales', Icons.store_mall_directory_rounded, '/branches'),
      _DashItem('Reportes', Icons.insights_rounded, '/reports'),
      _DashItem('Productos', Icons.inventory_rounded, '/products'),
      _DashItem('Cronometraje lotes', Icons.timer_rounded, '/batches'),
      _DashItem('Mapa de mesas', Icons.table_restaurant_rounded, '/tables'),
      _DashItem('Logística envíos', Icons.delivery_dining_rounded, '/shipping'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel principal'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              final repo = ref.read(authRepositoryProvider);
              await repo.clearSession();
              ref.read(authControllerProvider.notifier).setUnauthenticated();
              if (context.mounted) context.go('/login');
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
            SizedBox(
              height: 120,
              child: ordersAsync.when(
                data: (orders) {
                  final now = DateTime.now();
                 double orderTotal(OrderModel o) => o.items.fold<double>(
                          0.0,
                          (double previous, OrderItemModel item) =>
                              previous + (item.unitPrice as num).toDouble() * item.quantity,
                        );


                  final daily = orders
                      .where((o) => _sameDay(o.createdAt, now))
                      .fold<double>(0.0, (p, o) => p + orderTotal(o));
                  final monthly = orders
                      .where(
                        (o) =>
                            o.createdAt.year == now.year &&
                            o.createdAt.month == now.month,
                      )
                      .fold<double>(0.0, (p, o) => p + orderTotal(o));
                  return Row(
                    children: [
                      Expanded(
                        child: _KpiCard(
                          title: 'Ventas hoy',
                          value: 'Q${daily.toStringAsFixed(2)}',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _KpiCard(
                          title: 'Ventas mes',
                          value: 'Q${monthly.toStringAsFixed(2)}',
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Center(child: Text('Error: $e')),
              ),
            ),
            // const SizedBox(height: 16),
            // SizedBox(
            //   height: 120,
            //   child: ordersAsync.when(
            //     data: (orders) {
            //       // Top tamal más vendido y proporción picante desde órdenes
            //       // Los items de orden incluyen el producto completo
            //       final tamalItems = <OrderItemModel>[];
            //       for (final order in orders) {
            //         for (final item in order.items) {
            //           final product = item.product;
            //           if (product != null) {
            //             // Detectar tamales por nombre o descripción
            //             final nameLower = product.name.toLowerCase();
            //             final descLower = product.description.toLowerCase();
            //             if (nameLower.contains('tamal') || descLower.contains('tamal')) {
            //               tamalItems.add(item);
            //             }
            //           }
            //         }
            //       }
                  
            //       final counts = <String, int>{};
            //       int spicy = 0, noSpicy = 0;
                  
            //       for (final it in tamalItems) {
            //         final product = it.product;
            //         if (product != null) {
            //           final name = product.name.isNotEmpty ? product.name : 'Producto desconocido';
            //           final quantity = it.quantity;
                      
            //           // Contar por nombre de producto
            //           counts.update(
            //             name,
            //             (v) => v + quantity,
            //             ifAbsent: () => quantity,
            //           );
                      
            //           // Contar picante vs no picante desde el nombre o descripción
            //           final nameLower = name.toLowerCase();
            //           final descLower = product.description.toLowerCase();
            //           final fullText = '$nameLower $descLower';
                      
            //           if (fullText.contains('chapin') || fullText.contains('suave')) {
            //             spicy += quantity;
            //           } else if (fullText.contains('sin') && (fullText.contains('picante') || fullText.contains('sin picante'))) {
            //             noSpicy += quantity;
            //           } else {
            //             // Si no se detecta claramente, contar como sin picante por defecto
            //             noSpicy += quantity;
            //           }
            //         }
            //       }
                  
            //       final top = counts.entries.isEmpty
            //           ? '—'
            //           : counts.entries
            //                 .reduce((a, b) => a.value >= b.value ? a : b)
            //                 .key;
                  
            //       final total = spicy + noSpicy;
            //       String ratio;
            //       if (total == 0) {
            //         ratio = '—';
            //       } else {
            //         final spicyPercent = ((spicy / total) * 100).toStringAsFixed(0);
            //         final noSpicyPercent = ((noSpicy / total) * 100).toStringAsFixed(0);
            //         ratio = '$spicyPercent% picante / $noSpicyPercent% sin picante';
            //       }
                  
                //   return Row(
                //     children: [
                //       Expanded(
                //         child: _KpiCard(title: 'Tamal destacado', value: top),
                //       ),
                //       const SizedBox(width: 12),
                //       Expanded(
                //         child: _KpiCard(
                //           title: 'Picante vs no picante',
                //           value: ratio,
                //           isCompact: true,
                //         ),
                //       ),
                //     ],
                //   );
                // },
              //   loading: () => const Center(child: CircularProgressIndicator()),
              //   error: (e, st) => Center(child: Text('Error: $e')),
              // ),
            // ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _DashCard(
                    title: item.title,
                    icon: item.icon,
                    color: colorScheme.primary,
                    onTap: () => context.push(item.route),
                  );
                },
              ),
            ),
              ],
            ),
          ),
          const AiAssistantBubble(),
        ],
      ),
    );
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashItem {
  _DashItem(this.title, this.icon, this.route);
  final String title;
  final IconData icon;
  final String route;
}

class _DashCard extends StatelessWidget {
  const _DashCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [color.withAlpha((255 * 0.12).toInt()), color.withAlpha((255 * 0.04).toInt())],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Icon(icon, size: 34, color: color.withAlpha((255 * 0.9).toInt())),
              ),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
