import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/catalog_providers.dart';
import '../data/product_providers.dart';
import '../data/models/product_model.dart';
import '../../../core/network/dio_provider.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  late Future<List<ProductModel>> _future;
  List<ProductModel> _products = <ProductModel>[];
  String _query = '';
  bool _importing = false;

  @override
  void initState() {
    super.initState();
    _future = _loadProducts();
  }

  Future<List<ProductModel>> _loadProducts() async {
    final repo = ref.read(catalogRepositoryProvider);
    final products = await repo.fetchAll();
    if (!mounted) return products;
    setState(() => _products = products);
    return products;
  }

  Future<void> _refresh() async {
    setState(() {
      _future = _loadProducts();
    });
  }

  Future<void> _runImport() async {
    if (_importing) return;
    setState(() => _importing = true);
    try {
      final dio = ref.read(dioProvider);
      await dio.post(
        '/knowledge/import',
        data: const {'source': 'ProductBase'},
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vectorización enviada a IA.')),
      );
    } on DioException catch (e) {
      final responseBody = e.response?.data;
      final serverMessage = responseBody is Map<String, dynamic>
          ? responseBody['message']?.toString()
          : null;
      final message =
          serverMessage ?? e.message ?? 'Ocurrió un error inesperado.';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo registrar en IA: $message')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo registrar en IA: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _importing = false);
      } else {
        _importing = false;
      }
    }
  }

  Future<void> _onCreate(BuildContext context) async {
    final request = await _ProductCard._showProductForm(context, product: null);
    if (request == null) return;
    try {
      final api = ref.read(productApiProvider);
      await api.createProduct(request);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto creado')),
      );
      await _refresh();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _query.isEmpty
        ? _products
        : _products
              .where(
                (p) =>
                    p.name.toLowerCase().contains(_query.toLowerCase()) ||
                    p.description.toLowerCase().contains(_query.toLowerCase()),
              )
              .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de productos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onCreate(context),
        child: const Icon(Icons.add_rounded),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              _products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError && _products.isEmpty) {
            return Center(child: Text('Error al cargar: ${snapshot.error}'));
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Buscar por nombre o descripción',
                  ),
                  onChanged: (value) => setState(() => _query = value.trim()),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: _importing ? null : _runImport,
                    icon: _importing
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.auto_awesome_outlined),
                    label: Text(
                      _importing ? 'Registrando...' : 'Registrar en IA',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Center(child: Text('No se encontraron productos.')),
                  )
                else
                  ...filtered.map((product) => _ProductCard(
                    product: product,
                    onRefresh: _refresh,
                  )),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProductCard extends ConsumerWidget {
  const _ProductCard({
    required this.product,
    required this.onRefresh,
  });

  final ProductModel product;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final detailChips = _buildDetailChips(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    product.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) async {
                    switch (value) {
                      case 'edit':
                        await _onEdit(context, ref);
                        break;
                      case 'delete':
                        await _onDelete(context, ref);
                        break;
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'edit', child: Text('Editar')),
                    PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              product.description.isEmpty
                  ? 'Sin descripción'
                  : product.description,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildInfoChip(context, _categoryLabel(product.category)),
                _buildStatusChip(context),
                _buildInfoChip(
                  context,
                  'Precio: Q${product.price.toStringAsFixed(2)}',
                ),
                _buildInfoChip(context, 'Stock: ${product.stock}'),
                ...detailChips,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onEdit(BuildContext context, WidgetRef ref) async {
    final request = await _ProductCard._showProductForm(context, product: product);
    if (request == null) return;
    try {
      final api = ref.read(productApiProvider);
      await api.updateProduct(product.id, request);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto actualizado')),
      );
      onRefresh();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar: $e')),
      );
    }
  }

  Future<void> _onDelete(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: Text('¿Seguro que deseas eliminar ${product.name}?'),
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
      final api = ref.read(productApiProvider);
      await api.deleteProduct(product.id);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto eliminado')),
      );
      onRefresh();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar: $e')),
      );
    }
  }

  static Future<Map<String, dynamic>?> _showProductForm(
    BuildContext context, {
    ProductModel? product,
  }) async {
    final nameCtrl = TextEditingController(text: product?.name ?? '');
    final descCtrl = TextEditingController(text: product?.description ?? '');
    final priceCtrl = TextEditingController(
      text: product?.price.toStringAsFixed(2) ?? '0.00',
    );
    final stockCtrl = TextEditingController(text: product?.stock.toString() ?? '0');
    final active = ValueNotifier<bool>(product?.active ?? true);

    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => ValueListenableBuilder<bool>(
        valueListenable: active,
        builder: (context, isActive, _) => AlertDialog(
          title: Text(product == null ? 'Nuevo producto' : 'Editar producto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                  enabled: product == null,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Precio',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: stockCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Activo:'),
                    const SizedBox(width: 8),
                    Switch(
                      value: isActive,
                      onChanged: (value) => active.value = value,
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(ctx, {
                  'Name': nameCtrl.text.trim(),
                  'Description': descCtrl.text.trim(),
                  'Price': double.tryParse(priceCtrl.text.trim()) ?? 0.0,
                  'Stock': int.tryParse(stockCtrl.text.trim()) ?? 0,
                  'Active': isActive,
                  'CreatedAt': (product?.createdAt ?? DateTime.now()).toIso8601String(),
                });
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  static String _categoryLabel(ProductCategory category) {
    switch (category) {
      case ProductCategory.tamal:
        return 'Tamal';
      case ProductCategory.beverage:
        return 'Bebida';
      case ProductCategory.generic:
        return 'Genérico';
    }
  }

  Widget _buildStatusChip(BuildContext context) {
    final theme = Theme.of(context);
    final color = product.active
        ? theme.colorScheme.primary
        : theme.colorScheme.error;
    final label = product.active ? 'Activo' : 'Inactivo';
    return Chip(
      backgroundColor: color.withAlpha((255 * 0.12).toInt()),
      label: Text(label),
      labelStyle: theme.textTheme.labelMedium?.copyWith(color: color),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildInfoChip(BuildContext context, String label) {
    return Chip(
      label: Text(label),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  List<Widget> _buildDetailChips(BuildContext context) {
    final chips = <Widget>[];
    final tamal = product.tamal;
    if (tamal != null) {
      chips
        ..add(_buildInfoChip(context, 'Masa: ${tamal.doughType}'))
        ..add(_buildInfoChip(context, 'Relleno: ${tamal.filling}'))
        ..add(_buildInfoChip(context, 'Envoltura: ${tamal.wrapper}'))
        ..add(_buildInfoChip(context, 'Picante: ${tamal.spiceLevel}'));
      return chips;
    }
    final beverage = product.beverage;
    if (beverage != null) {
      chips
        ..add(_buildInfoChip(context, 'Tipo: ${beverage.type}'))
        ..add(_buildInfoChip(context, 'Endulzante: ${beverage.sweetener}'))
        ..add(_buildInfoChip(context, 'Tamaño: ${beverage.size}'));
      if ((beverage.topping ?? '').isNotEmpty) {
        chips.add(_buildInfoChip(context, 'Topping: ${beverage.topping}'));
      }
    }
    return chips;
  }
}
