import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../orders/data/models/order_model.dart';
import '../../orders/data/order_providers.dart';
import '../../sales/data/models/sale_model.dart';
import '../../sales/data/sale_providers.dart';

class BranchReportsScreen extends ConsumerStatefulWidget {
  const BranchReportsScreen({super.key});

  @override
  ConsumerState<BranchReportsScreen> createState() =>
      _BranchReportsScreenState();
}

class _BranchReportsScreenState extends ConsumerState<BranchReportsScreen> {
  DateTimeRange? _range;
  bool _loading = false;
  String? _errorMessage;

  int _ordersCount = 0;
  double _ordersTotal = 0;
  double _salesTotal = 0;

  List<OrderModel> _allOrders = const [];
  List<SaleModel> _allSales = const [];

  @override
  void initState() {
    super.initState();
    _loadMetrics();
  }

  Future<void> _loadMetrics() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    List<OrderModel> orders = const [];
    List<SaleModel> sales = const [];

    try {
      final ordersApi = ref.read(orderApiProvider);
      orders = await ordersApi.fetchOrders();
    } catch (error, stackTrace) {
      _reportLoadError(
        message: 'No se pudieron obtener las ordenes: $error',
        stackTrace: stackTrace,
      );
    }

    try {
      final salesRepo = ref.read(saleRepositoryProvider);
      sales = await salesRepo.fetchSales();
    } catch (error, stackTrace) {
      _reportLoadError(
        message: 'No se pudieron obtener las ventas: $error',
        stackTrace: stackTrace,
      );
    }

    if (!mounted) return;

    final metrics = _computeMetrics(
      orders: orders,
      sales: sales,
      range: _range,
    );

    setState(() {
      _allOrders = orders;
      _allSales = sales;
      _ordersCount = metrics.ordersCount;
      _ordersTotal = metrics.ordersTotal;
      _salesTotal = metrics.salesTotal;
      _loading = false;
    });
  }

  void _reportLoadError({
    required String message,
    StackTrace? stackTrace,
  }) {
    _errorMessage = message;
    debugPrint('BranchReportsScreen: $message');
    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }
  }

  _Metrics _computeMetrics({
    required List<OrderModel> orders,
    required List<SaleModel> sales,
    DateTimeRange? range,
  }) {
    final selectedRange = range;
    final start = selectedRange?.start;
    final end = selectedRange?.end;

    bool inRange(DateTime date) {
      if (start == null || end == null) return true;
      final from = DateTime(start.year, start.month, start.day);
      final to = DateTime(end.year, end.month, end.day, 23, 59, 59, 999);
      final normalized = DateTime(
        date.year,
        date.month,
        date.day,
        date.hour,
        date.minute,
        date.second,
      );
      return !normalized.isBefore(from) && !normalized.isAfter(to);
    }

    final filteredOrders =
        orders.where((order) => inRange(order.createdAt)).toList();
    final filteredSales =
        sales.where((sale) => inRange(sale.date)).toList();

    final ordersTotal = filteredOrders.fold<double>(
      0,
      (total, order) => total +
          order.items.fold<double>(
            0,
            (subtotal, item) => subtotal + item.unitPrice * item.quantity,
          ),
    );

    final salesTotal = filteredSales.fold<double>(
      0,
      (total, sale) => total + sale.total,
    );

    return _Metrics(
      ordersCount: filteredOrders.length,
      ordersTotal: ordersTotal,
      salesTotal: salesTotal,
    );
  }

  Future<void> _onSelectRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 1),
      initialDateRange: _range,
    );
    if (picked == null) return;

    final metrics = _computeMetrics(
      orders: _allOrders,
      sales: _allSales,
      range: picked,
    );

    setState(() {
      _range = picked;
      _ordersCount = metrics.ordersCount;
      _ordersTotal = metrics.ordersTotal;
      _salesTotal = metrics.salesTotal;
    });
  }

  Future<void> _exportCsv() async {
    final metrics = _computeMetrics(
      orders: _allOrders,
      sales: _allSales,
      range: _range,
    );

    final headers = ['Metrica', 'Valor'];
    final dateRange = _range != null
        ? '${_range!.start.toString().split(' ').first} - '
            '${_range!.end.toString().split(' ').first}'
        : 'Todos';
    final rows = <List<String>>[
      ['Periodo', dateRange],
      ['Ordenes registradas', '${metrics.ordersCount}'],
      ['Total ordenes (Q)', metrics.ordersTotal.toStringAsFixed(2)],
      // ['Ventas registradas (Q)', metrics.salesTotal.toStringAsFixed(2)],
    ];

    final csv = StringBuffer()
      ..writeln(headers.join(','))
      ..writeln(rows
          .map((row) => row.map((cell) => '"$cell"').join(','))
          .join('\n'));

    late final File file;
    if (Platform.isAndroid) {
      final downloads = Directory('/storage/emulated/0/Download');
      if (!downloads.existsSync()) downloads.createSync(recursive: true);
      file = File(
        '${downloads.path}/reporte_${DateTime.now().millisecondsSinceEpoch}.csv',
      );
    } else {
      final dir = await getApplicationDocumentsDirectory();
      file = File(
        '${dir.path}/reporte_${DateTime.now().millisecondsSinceEpoch}.csv',
      );
    }

    await file.writeAsString(csv.toString());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('CSV guardado en: ${file.path}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasData = _allOrders.isNotEmpty || _allSales.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Reportes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.date_range_rounded),
                    label: Text(
                      _range == null
                          ? 'Rango de fechas'
                          : '${_range!.start.toString().split(' ').first} - '
                              '${_range!.end.toString().split(' ').first}',
                    ),
                    onPressed: _allOrders.isEmpty && _allSales.isEmpty
                        ? null
                        : _onSelectRange,
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: hasData ? _exportCsv : null,
                  child: const Text('Exportar CSV'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _loading && !hasData
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: _loadMetrics,
                      child: ListView(
                        children: [
                          // if (_errorMessage != null)
                          //   Padding(
                          //     padding: const EdgeInsets.only(
                          //       left: 16,
                          //       right: 16,
                          //       bottom: 16,
                          //     ),
                          //     child: Text(
                          //       _errorMessage!,
                          //       style: Theme.of(context)
                          //           .textTheme
                          //           .bodyMedium
                          //           ?.copyWith(color: Colors.red),
                          //     ),
                          //   ),
                          ListTile(
                            title: const Text('Ordenes registradas'),
                            trailing: Text('$_ordersCount'),
                          ),
                          ListTile(
                            title: const Text('Total ordenes (Q)'),
                            trailing:
                                Text('Q${_ordersTotal.toStringAsFixed(2)}'),
                          ),
                          // ListTile(
                          //   title: const Text('Ventas registradas (Q)'),
                          //   trailing:
                          //       Text('Q${_salesTotal.toStringAsFixed(2)}'),
                          // ),
                          if (_loading && hasData)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metrics {
  const _Metrics({
    required this.ordersCount,
    required this.ordersTotal,
    required this.salesTotal,
  });

  final int ordersCount;
  final double ordersTotal;
  final double salesTotal;
}
