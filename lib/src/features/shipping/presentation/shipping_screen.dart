import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../orders/data/order_providers.dart';
import '../../../core/storage/hive_providers.dart';

class ShippingScreen extends ConsumerStatefulWidget {
  const ShippingScreen({super.key});

  @override
  ConsumerState<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends ConsumerState<ShippingScreen> {
  List<_Delivery> _deliveries = [];
  bool _loading = true;
  Box<String>? _deliveryBox;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    try {
      _deliveryBox ??= await ref.read(hiveServiceProvider).openBox<String>('delivery_statuses');
      final api = ref.read(orderApiProvider);
      final orders = await api.fetchOrders();
      final deliveries = orders.map((o) {
        final total = o.items.fold<double>(0, (p, it) => p + it.unitPrice * it.quantity);
        return _Delivery(
          orderId: o.id,
          address: 'Orden ${o.id.substring(0, 8)}',
          amount: total,
          createdAt: o.createdAt,
        );
      }).toList();
      
      // Cargar estados guardados
      for (final d in deliveries) {
        final stored = _deliveryBox!.get(d.orderId);
        if (stored != null) {
          final status = jsonDecode(stored)['status'] as String?;
          d.status = status ?? d.status;
        }
      }
      
      setState(() {
        _deliveries = deliveries;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar envíos: $e')),
      );
    }
  }

  Future<void> _saveDeliveryStatus(_Delivery delivery) async {
    _deliveryBox ??= await ref.read(hiveServiceProvider).openBox<String>('delivery_statuses');
    await _deliveryBox!.put(delivery.orderId, jsonEncode({'status': delivery.status}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logística de envíos')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadOrders,
              child: ListView.separated(
                itemCount: _deliveries.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  final d = _deliveries[i];
                  return ListTile(
                    title: Text(d.address),
                    subtitle: Text('Q${d.amount.toStringAsFixed(2)} • ${d.createdAt.toString().substring(0, 10)}'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        setState(() => d.status = value);
                        _saveDeliveryStatus(d);
                      },
                      itemBuilder: (ctx) => const [
                        PopupMenuItem(value: 'pendiente', child: Text('Pendiente')),
                        PopupMenuItem(value: 'en_ruta', child: Text('En ruta')),
                        PopupMenuItem(value: 'entregado', child: Text('Entregado')),
                      ],
                    ),
                    leading: Icon(
                      switch (d.status) {
                        'pendiente' => Icons.pending_outlined,
                        'en_ruta' => Icons.local_shipping_outlined,
                        'entregado' => Icons.check_circle_outline,
                        _ => Icons.help_outline,
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class _Delivery {
  _Delivery({
    required this.orderId,
    required this.address,
    required this.amount,
    required this.createdAt,
  });
  final String orderId;
  final String address;
  final double amount;
  final DateTime createdAt;
  String status = 'pendiente';
}


