import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/offline/offline_queue.dart';
import '../../../core/offline/offline_providers.dart';
import '../../combos/data/models/combo_model.dart';
import '../../catalog/data/product_providers.dart';
import '../../../core/notifications/notification_providers.dart';
import '../../auth/presentation/controllers/auth_controller.dart';
import '../../../core/storage/secure_storage_provider.dart';
import 'dart:convert';
import 'offline_queue_screen.dart';
import 'package:cazuela_chapina_app/src/core/utils/logger.dart';

enum TamalMasa { amarillo, blanco, arroz }
enum TamalRelleno { cerdoRojo, polloNegro, chipilin, mezcla }
enum TamalEnvio { platano, tusa }
enum TamalPicante { sin, suave, chapin }

enum BebidaTipo { atolElote, shuco, pinol, cacao }
enum BebidaEndulzante { panela, miel, sin }

class OfflineSaleScreen extends ConsumerStatefulWidget {
  const OfflineSaleScreen({super.key});

  @override
  ConsumerState<OfflineSaleScreen> createState() => _OfflineSaleScreenState();
}

class _OfflineSaleScreenState extends ConsumerState<OfflineSaleScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab = TabController(length: 3, vsync: this);

  final List<Map<String, dynamic>> _items = [];

  late Future<List<ComboModel>> _combosFuture;

  @override
  void initState() {
    super.initState();
    final productApi = ref.read(productApiProvider);
    _combosFuture = productApi.fetchCombos();
  }

  // Tamal
  int _tamalCantidad = 1; // 1, 6, 12
  TamalMasa _masa = TamalMasa.amarillo;
  TamalRelleno _relleno = TamalRelleno.cerdoRojo;
  TamalEnvio _envoltura = TamalEnvio.platano;
  TamalPicante _picante = TamalPicante.sin;

  // Bebida
  String _bebidaTamanio = '12oz'; // '12oz' | '1L'
  BebidaTipo _bebida = BebidaTipo.atolElote;
  BebidaEndulzante _endulzante = BebidaEndulzante.panela;
  final Set<String> _toppings = {};

  double get _total => _items.fold<double>(0, (p, e) => p + (e['UnitPrice'] as num).toDouble() * (e['Quantity'] as int));

  Future<void> _addTamal() async {
    final precioBase = _tamalCantidad == 12 ? 180.0 : _tamalCantidad == 6 ? 95.0 : 18.0;
    final unitPrice = precioBase / _tamalCantidad;
    
    final productId = const Uuid().v4();
    final masaStr = _masa.toString().split('.').last;
    final rellenoStr = _relleno.toString().split('.').last;
    final envueltoStr = _envoltura.toString().split('.').last;
    final picanteStr = _picante.toString().split('.').last;
    
    final productName = 'Tamal $masaStr $rellenoStr $envueltoStr $picanteStr';
    
    final queue = ref.read(offlineQueueProvider);
    final productPayloadId = const Uuid().v4();
    final productPayload = OfflinePayload(
      id: productPayloadId,
      endpoint: '/product/tamal',
      method: 'POST',
      body: {
        'name': productName,
        'description': 'Tamal personalizado: masa $masaStr, relleno $rellenoStr, envuelto en $envueltoStr, picante $picanteStr',
        'price': unitPrice,
        'active': true,
        'stock': 999,
        'doughType': masaStr,
        'filling': rellenoStr,
        'wrapper': envueltoStr,
        'spiceLevel': picanteStr,
        'tempProductId': productId, // Guardar el ID temporal para mapeo
      },
      createdAt: DateTime.now(),
    );
    await queue.enqueue(productPayload);
    
    _items.add({
      'ProductId': productId,
      'Quantity': _tamalCantidad,
      'UnitPrice': unitPrice,
      'tempProductId': productId, 
      'productPayloadId': productPayload.id, 
      'productName': productName, 
      'isCombo': false, 
    });
    setState(() {});
  }

  Future<void> _addBebida() async {
    final unit = _bebidaTamanio == '1L' ? 25.0 : 12.0;
    
    final productId = const Uuid().v4();
    final tipoStr = _bebida.toString().split('.').last;
    final endulzanteStr = _endulzante.toString().split('.').last;
    final toppingsStr = _toppings.isEmpty ? null : _toppings.join(', ');
    
    final productName = 'Bebida $tipoStr $endulzanteStr $_bebidaTamanio';
    
    final queue = ref.read(offlineQueueProvider);
    final productPayloadId = const Uuid().v4();
    final productPayload = OfflinePayload(
      id: productPayloadId,
      endpoint: '/product/beverage',
      method: 'POST',
      body: {
        'name': productName,
        'description': 'Bebida personalizada: tipo $tipoStr, endulzante $endulzanteStr, tamaño $_bebidaTamanio',
        'price': unit,
        'active': true,
        'stock': 999,
        'type': tipoStr,
        'sweetener': endulzanteStr,
        'topping': toppingsStr,
        'size': _bebidaTamanio,
        'tempProductId': productId, // Guardar el ID temporal para mapeo
      },
      createdAt: DateTime.now(),
    );
    await queue.enqueue(productPayload);
    
    _items.add({
      'ProductId': productId,
      'Quantity': 1,
      'UnitPrice': unit,
      'tempProductId': productId,
      'productPayloadId': productPayload.id,
      'productName': productName, 
      'isCombo': false, 
    });
    setState(() {});
  }

  void _addCombo(String id, String name, double price) {
    _items.add({
      'ProductId': id,
      'Quantity': 1,
      'UnitPrice': price,
      'productName': name, 
      'isCombo': true, // Marcar que es un combo (no necesita crear venta)
    });
    setState(() {});
  }

  Future<void> _queueSale() async {
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agrega productos a la venta')),
      );
      return;
    }
    final queue = ref.read(offlineQueueProvider);
    final auth = ref.read(authControllerProvider);
    String userId = auth.userEmail ?? auth.userName ?? 'usuario';
    try {
      final token = await ref.read(secureStorageProvider).getAccessToken();
      if (token != null && token.split('.').length == 3) {
        final payload = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(token.split('.')[1])))) as Map<String, dynamic>;
        userId = (payload['sub'] as String?) ?? userId; 
        logDebug('offline userId: $userId');
      }
    } catch (e) {
      logDebug('offline JWT error: $e');
    }
    
    final combosItems = _items.where((it) => it['isCombo'] == true).toList();
    final productItems = _items.where((it) => it['isCombo'] != true).toList();
    
    // debug
    logDebug('offline final userId: $userId, combos: ${combosItems.length}, productos: ${productItems.length}, total: $_total');
    
    // Para combos: solo crear la venta (los productos ya existen)
    if (combosItems.isNotEmpty) {
      final combosTotal = combosItems.fold<double>(0, (p, e) => p + (e['UnitPrice'] as num).toDouble() * (e['Quantity'] as int));
      final combosPayload = OfflinePayload(
        id: const Uuid().v4(),
        endpoint: '/sale/create',
        method: 'POST',
        body: {
          'date': DateTime.now().toUtc().toIso8601String(),
          'userId': userId,
          'total': combosTotal,
          'items': [
            for (final it in combosItems)
              {
                'productId': it['ProductId'] ?? it['productId'],
                'quantity': it['Quantity'] ?? it['quantity'],
                'unitPrice': (it['UnitPrice'] ?? it['unitPrice']).toDouble(),
              }
          ]
        },
        createdAt: DateTime.now(),
      );
      await queue.enqueue(combosPayload);
    }
    

    if (productItems.isNotEmpty) {
      final productsTotal = productItems.fold<double>(0, (p, e) => p + (e['UnitPrice'] as num).toDouble() * (e['Quantity'] as int));
      final productsPayload = OfflinePayload(
        id: const Uuid().v4(),
        endpoint: '/sale/create',
        method: 'POST',
        body: {
          'date': DateTime.now().toUtc().toIso8601String(),
          'userId': userId,
          'total': productsTotal,
          'items': [
            for (final it in productItems)
              {
                'productId': it['ProductId'] ?? it['productId'],
                'quantity': it['Quantity'] ?? it['quantity'],
                'unitPrice': (it['UnitPrice'] ?? it['unitPrice']).toDouble(),
                'tempProductId': it['tempProductId'], 
              }
          ]
        },
        createdAt: DateTime.now(),
      );
      await queue.enqueue(productsPayload);
    }

    // Notificación local
    try {
      final notif = ref.read(notificationServiceProvider);
      await notif.init();
      await notif.showNotification(
        title: 'Venta offline encolada',
        body: 'Venta por Q${_total.toStringAsFixed(2)} guardada. Se enviará al recuperar conexión.',
      );
    } catch (_) {}

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Venta encolada. Se enviará al recuperar conexión.')),
    );
    setState(() => _items.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venta offline'),
        bottom: TabBar(
          controller: _tab,
          tabs: const [
            Tab(text: 'Tamales'),
            Tab(text: 'Bebidas'),
            Tab(text: 'Combos'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Ver cola',
            icon: const Icon(Icons.list_alt_rounded),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const OfflineQueueScreen()),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _buildTamales(),
                _buildBebidas(),
                _buildCombos(),
              ],
            ),
          ),
          _buildCart(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _queueSale,
              icon: const Icon(Icons.cloud_upload_rounded),
              label: Text('Encolar venta  -  Q${_total.toStringAsFixed(2)}'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTamales() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Unidad'),
                selected: _tamalCantidad == 1,
                onSelected: (_) => setState(() => _tamalCantidad = 1),
              ),
              ChoiceChip(
                label: const Text('1/2 docena'),
                selected: _tamalCantidad == 6,
                onSelected: (_) => setState(() => _tamalCantidad = 6),
              ),
              ChoiceChip(
                label: const Text('Docena'),
                selected: _tamalCantidad == 12,
                onSelected: (_) => setState(() => _tamalCantidad = 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _segmented<TamalMasa>('Masa', TamalMasa.values, _masa,
              (v) => setState(() => _masa = v)),
          const SizedBox(height: 8),
          _segmented<TamalRelleno>('Relleno', TamalRelleno.values, _relleno,
              (v) => setState(() => _relleno = v)),
          const SizedBox(height: 8),
          _segmented<TamalEnvio>('Envoltura', TamalEnvio.values, _envoltura,
              (v) => setState(() => _envoltura = v)),
          const SizedBox(height: 8),
          _segmented<TamalPicante>('Picante', TamalPicante.values, _picante,
              (v) => setState(() => _picante = v)),
          const SizedBox(height: 16),
          SizedBox(
            height: 44,
            child: OutlinedButton.icon(
              onPressed: _addTamal,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Agregar tamal'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBebidas() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('12 oz'),
                selected: _bebidaTamanio == '12oz',
                onSelected: (_) => setState(() => _bebidaTamanio = '12oz'),
              ),
              ChoiceChip(
                label: const Text('1 L'),
                selected: _bebidaTamanio == '1L',
                onSelected: (_) => setState(() => _bebidaTamanio = '1L'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _segmented<BebidaTipo>('Tipo', BebidaTipo.values, _bebida,
              (v) => setState(() => _bebida = v)),
          const SizedBox(height: 8),
          _segmented<BebidaEndulzante>('Endulzante', BebidaEndulzante.values,
              _endulzante, (v) => setState(() => _endulzante = v)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: const Text('Malvaviscos'),
                selected: _toppings.contains('malvaviscos'),
                onSelected: (s) => setState(() {
                  s ? _toppings.add('malvaviscos') : _toppings.remove('malvaviscos');
                }),
              ),
              FilterChip(
                label: const Text('Canela'),
                selected: _toppings.contains('canela'),
                onSelected: (s) => setState(() {
                  s ? _toppings.add('canela') : _toppings.remove('canela');
                }),
              ),
              FilterChip(
                label: const Text('Ralladura cacao'),
                selected: _toppings.contains('ralladura_cacao'),
                onSelected: (s) => setState(() {
                  s
                      ? _toppings.add('ralladura_cacao')
                      : _toppings.remove('ralladura_cacao');
                }),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 44,
            child: OutlinedButton.icon(
              onPressed: _addBebida,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Agregar bebida'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCombos() {
    return FutureBuilder<List<ComboModel>>(
      future: _combosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
        final combos = snapshot.data ?? const <ComboModel>[];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              for (final c in combos)
                Card(
                  child: ListTile(
                    title: Text(c.name),
                    subtitle: Text(c.description),
                    trailing: Text('Q${c.price.toStringAsFixed(2)}'),
                    onTap: () => _addCombo(c.id, c.name, c.price),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCart() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      height: 140,
      child: _items.isEmpty
          ? const Center(child: Text('Sin productos aún'))
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              itemCount: _items.length,
              itemBuilder: (_, i) {
                final it = _items[i];
                final name = it['productName'] ?? 'Producto ${i + 1}';
                final quantity = it['Quantity'] ?? it['quantity'] ?? 1;
                final price = (it['UnitPrice'] ?? it['unitPrice'] ?? 0.0) * quantity;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Chip(
                    label: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'x$quantity - Q${price.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    onDeleted: () => setState(() => _items.removeAt(i)),
                  ),
                );
              },
            ),
    );
  }

  Widget _segmented<T>(String label, List<T> values, T current, ValueChanged<T> onChanged) {
    final entries = <MapEntry<T, Widget>>[
      for (final v in values) MapEntry(v, Text(v.toString().split('.').last))
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 6),
        SegmentedButton<T>(
          segments: [
            for (final e in entries)
              ButtonSegment<T>(value: e.key, label: e.value),
          ],
          selected: {current},
          onSelectionChanged: (s) => onChanged(s.first),
        ),
      ],
    );
  }
}
