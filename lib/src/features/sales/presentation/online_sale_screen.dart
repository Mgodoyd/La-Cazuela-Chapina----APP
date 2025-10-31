import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

import '../data/sale_providers.dart';
import '../data/models/sale_request.dart';
import '../../auth/presentation/controllers/auth_controller.dart';
import '../../../core/storage/secure_storage_provider.dart';
import '../../../core/notifications/notification_providers.dart';
import '../../catalog/data/catalog_providers.dart';
import '../../catalog/data/product_providers.dart';
import '../../catalog/data/models/product_model.dart';
import 'package:cazuela_chapina_app/src/core/utils/logger.dart';


enum TamalMasa { amarillo, blanco, arroz }
enum TamalRelleno { cerdoRojo, polloNegro, chipilin, mezcla }
enum TamalEnvio { platano, tusa }
enum TamalPicante { sin, suave, chapin }

enum BebidaTipo { atolElote, champurrado, atolBlanco }
enum BebidaEndulzante { panela, azucar, ninguno }

class OnlineSaleScreen extends ConsumerStatefulWidget {
  const OnlineSaleScreen({super.key});

  @override
  ConsumerState<OnlineSaleScreen> createState() => _OnlineSaleScreenState();
}

class _OnlineSaleScreenState extends ConsumerState<OnlineSaleScreen> {
  final List<Map<String, dynamic>> _items = [];

  double get _total => _items.fold<double>(0, (p, e) => p + (e['UnitPrice'] as num).toDouble() * (e['Quantity'] as int));

  void _addCustomItem() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) {
        final nameCtrl = TextEditingController();
        final priceCtrl = TextEditingController();
        final qtyCtrl = TextEditingController(text: '1');
        return AlertDialog(
          title: const Text('Agregar item personalizado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Producto')),
              TextField(controller: priceCtrl, decoration: const InputDecoration(labelText: 'Precio unitario'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
              TextField(controller: qtyCtrl, decoration: const InputDecoration(labelText: 'Cantidad'), keyboardType: TextInputType.number),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () async {
                final name = nameCtrl.text.trim();
                final price = double.tryParse(priceCtrl.text.trim()) ?? 0;
                final qty = int.tryParse(qtyCtrl.text.trim()) ?? 0;
                if (name.isEmpty || price <= 0 || qty <= 0) return;
                
                // Crear el producto primero
                try {
                  final productApi = ref.read(productApiProvider);
                  final productData = {
                    'name': name,
                    'description': 'Producto personalizado: $name',
                    'price': price,
                    'active': true,
                    'stock': 999,
                  };
                  final product = await productApi.createProduct(productData);
                  
                  Navigator.pop(ctx, {
                    'ProductId': product.id,
                    'name': name,
                    'Quantity': qty,
                    'UnitPrice': price,
                  });
                } catch (e) {
                  if (!ctx.mounted) return;
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    SnackBar(content: Text('Error al crear producto: $e')),
                  );
                }
              },
              child: const Text('Agregar'),
            )
          ],
        );
      },
    );
    if (result != null) {
      setState(() => _items.add(result));
    }
  }

  Future<void> _addProductFromCatalog() async {
    final products = await ref.read(catalogRepositoryProvider).fetchAllProducts();
    if (products.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay productos disponibles')),
      );
      return;
    }

    final product = await showDialog<ProductModel>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Seleccionar producto'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (_, i) {
              final p = products[i];
              return ListTile(
                title: Text(p.name),
                subtitle: Text('Q${p.price.toStringAsFixed(2)}'),
                onTap: () => Navigator.pop(ctx, p),
              );
            },
          ),
        ),
      ),
    );

    if (product != null) {
      final qty = await showDialog<int>(
        context: context,
        builder: (ctx) {
          final qtyCtrl = TextEditingController(text: '1');
          return AlertDialog(
            title: const Text('Cantidad'),
            content: TextField(
              controller: qtyCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Cantidad'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, 0),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () {
                  final qty = int.tryParse(qtyCtrl.text.trim()) ?? 0;
                  Navigator.pop(ctx, qty > 0 ? qty : 0);
                },
                child: const Text('Agregar'),
              ),
            ],
          );
        },
      );
      if (qty != null && qty > 0) {
        setState(() {
          _items.add({
            'ProductId': product.id,
            'name': product.name,
            'Quantity': qty,
            'UnitPrice': product.price,
          });
        });
      }
    }
  }

  Future<void> _addTamal() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) {
        int cantidad = 1;
        TamalMasa masa = TamalMasa.amarillo;
        TamalRelleno relleno = TamalRelleno.cerdoRojo;
        TamalEnvio envio = TamalEnvio.platano;
        TamalPicante picante = TamalPicante.sin;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Tamal personalizado'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('Unidad'),
                          selected: cantidad == 1,
                          onSelected: (_) => setDialogState(() => cantidad = 1),
                        ),
                        ChoiceChip(
                          label: const Text('1/2 docena'),
                          selected: cantidad == 6,
                          onSelected: (_) => setDialogState(() => cantidad = 6),
                        ),
                        ChoiceChip(
                          label: const Text('Docena'),
                          selected: cantidad == 12,
                          onSelected: (_) => setDialogState(() => cantidad = 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _segmentedDialog('Masa', TamalMasa.values, masa, (v) => setDialogState(() => masa = v)),
                    const SizedBox(height: 8),
                    _segmentedDialog('Relleno', TamalRelleno.values, relleno, (v) => setDialogState(() => relleno = v)),
                    const SizedBox(height: 8),
                    _segmentedDialog('Envoltura', TamalEnvio.values, envio, (v) => setDialogState(() => envio = v)),
                    const SizedBox(height: 8),
                    _segmentedDialog('Picante', TamalPicante.values, picante, (v) => setDialogState(() => picante = v)),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: () async {
                    final precioBase = cantidad == 12 ? 180.0 : cantidad == 6 ? 95.0 : 18.0;
                    final unitPrice = precioBase / cantidad;
                    final masaStr = masa.toString().split('.').last;
                    final rellenoStr = relleno.toString().split('.').last;
                    final envioStr = envio.toString().split('.').last;
                    final picanteStr = picante.toString().split('.').last;
                    
                    final productName = 'Tamal $masaStr $rellenoStr $envioStr $picanteStr';
                    
                    // Crear el producto primero
                    try {
                      final productApi = ref.read(productApiProvider);
                      final productData = {
                        'name': productName,
                        'description': 'Tamal personalizado: masa $masaStr, relleno $rellenoStr, envuelto en $envioStr, picante $picanteStr',
                        'price': unitPrice,
                        'active': true,
                        'stock': 999,
                      };
                      final product = await productApi.createProduct(productData);
                      
                      Navigator.pop(ctx, {
                        'ProductId': product.id,
                        'name': productName,
                        'Quantity': cantidad,
                        'UnitPrice': unitPrice,
                      });
                    } catch (e) {
                      if (!ctx.mounted) return;
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        SnackBar(content: Text('Error al crear producto: $e')),
                      );
                    }
                  },
                  child: const Text('Agregar'),
                ),
              ],
            );
          },
        );
      },
    );
    if (result != null) {
      setState(() => _items.add(result));
    }
  }

  Future<void> _addBebida() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) {
        String tamanio = '12oz';
        BebidaTipo tipo = BebidaTipo.atolElote;
        BebidaEndulzante endulzante = BebidaEndulzante.panela;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Bebida personalizada'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('12 oz'),
                          selected: tamanio == '12oz',
                          onSelected: (_) => setDialogState(() => tamanio = '12oz'),
                        ),
                        ChoiceChip(
                          label: const Text('1 L'),
                          selected: tamanio == '1L',
                          onSelected: (_) => setDialogState(() => tamanio = '1L'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _segmentedDialog('Tipo', BebidaTipo.values, tipo, (v) => setDialogState(() => tipo = v)),
                    const SizedBox(height: 8),
                    _segmentedDialog('Endulzante', BebidaEndulzante.values, endulzante, (v) => setDialogState(() => endulzante = v)),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: () async {
                    final unit = tamanio == '1L' ? 25.0 : 12.0;
                    final tipoStr = tipo.toString().split('.').last;
                    final endulzanteStr = endulzante.toString().split('.').last;
                    
                    final productName = 'Bebida $tipoStr $endulzanteStr $tamanio';
                    
                    // Crear el producto primero
                    try {
                      final productApi = ref.read(productApiProvider);
                      final productData = {
                        'name': productName,
                        'description': 'Bebida personalizada: tipo $tipoStr, endulzante $endulzanteStr, tamaño $tamanio',
                        'price': unit,
                        'active': true,
                        'stock': 999,
                      };
                      final product = await productApi.createProduct(productData);
                      
                      Navigator.pop(ctx, {
                        'ProductId': product.id,
                        'name': productName,
                        'Quantity': 1,
                        'UnitPrice': unit,
                      });
                    } catch (e) {
                      if (!ctx.mounted) return;
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        SnackBar(content: Text('Error al crear producto: $e')),
                      );
                    }
                  },
                  child: const Text('Agregar'),
                ),
              ],
            );
          },
        );
      },
    );
    if (result != null) {
      setState(() => _items.add(result));
    }
  }

  Widget _segmentedDialog<T>(String label, List<T> options, T value, ValueChanged<T> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((opt) {
            final isSelected = opt == value;
            return ChoiceChip(
              label: Text(_enumLabel(opt)),
              selected: isSelected,
              onSelected: (_) => onChanged(opt),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _enumLabel(dynamic value) {
    final str = value.toString().split('.').last;
    return str.replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m[1]}').trimLeft();
  }

  Future<void> _submitOnline() async {
    if (_items.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Agrega productos a la venta')));
      return;
    }
    final repo = ref.read(saleRepositoryProvider);
    final auth = ref.read(authControllerProvider);
    // Extraer userId del JWT
    String userId = auth.userEmail ?? auth.userName ?? 'usuario';
    try {
      final token = await ref.read(secureStorageProvider).getAccessToken();
      if (token != null && token.split('.').length == 3) {
        final payload = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(token.split('.')[1])))) as Map<String, dynamic>;
        userId = (payload['sub'] as String?) ?? userId;
        logDebug('DEBUG online userId: $userId');
      }
    } catch (e) {
      logDebug('DEBUG online JWT error: $e');
    }
    logDebug('DEBUG online final userId: $userId, items: $_items, total: $_total');
    final items = _items
        .map((e) => SaleItemRequest(
              productId: e['ProductId'] as String,
              quantity: e['Quantity'] as int,
              unitPrice: (e['UnitPrice'] as num).toDouble(),
            ))
        .toList();
    final request = SaleRequest(userId: userId, total: _total, items: items, date: DateTime.now());
    try {
      await repo.createSale(request, queueOnError: false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Venta creada')));
      setState(() => _items.clear());
      // notificación push
      try {
        final notif = ref.read(notificationServiceProvider);
        await notif.init();
        await notif.showNotification(
          title: 'Venta realizada',
          body: 'Venta por Q${_total.toStringAsFixed(2)} registrada exitosamente',
        );
      } catch (_) {}
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Venta online')),
      body: Column(
        children: [
          Expanded(
            child: _items.isEmpty
                ? const Center(child: Text('Sin productos aún'))
                : ListView.separated(
                    itemCount: _items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final it = _items[i];
                      return ListTile(
                        title: Text(it['name'] ?? it['ProductId'].toString()),
                        subtitle: Text('x${it['Quantity']} • Q${(it['UnitPrice'] as num).toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline_rounded),
                          onPressed: () => setState(() => _items.removeAt(i)),
                        ),
                      );
                    },
                  ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _addProductFromCatalog,
                          icon: const Icon(Icons.store_rounded),
                          label: const Text('Catálogo'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _addCustomItem,
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('Personalizado'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _addTamal,
                          icon: const Icon(Icons.lunch_dining_rounded),
                          label: const Text('Tamal'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _addBebida,
                          icon: const Icon(Icons.local_drink_rounded),
                          label: const Text('Bebida'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _submitOnline,
                      icon: const Icon(Icons.cloud_done_rounded),
                      label: Text('Crear venta  -  Q${_total.toStringAsFixed(2)}'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
