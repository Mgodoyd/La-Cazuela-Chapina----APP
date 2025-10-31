import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../core/storage/hive_providers.dart';

class TableMapScreen extends ConsumerStatefulWidget {
  const TableMapScreen({super.key});

  @override
  ConsumerState<TableMapScreen> createState() => _TableMapScreenState();
}

class _TableMapScreenState extends ConsumerState<TableMapScreen> {
  final int rows = 3;
  final int cols = 4;
  List<_TableCell> _cells = [];
  Box<String>? _tableBox;

  @override
  void initState() {
    super.initState();
    _loadTables();
  }

  Future<void> _loadTables() async {
    final hiveService = ref.read(hiveServiceProvider);
    _tableBox = await hiveService.openBox<String>('table_map');
    if (!mounted) return;
    final stored = _tableBox!.values
        .map((json) => _TableCell.fromMap(jsonDecode(json) as Map<String, dynamic>))
        .toList();
    setState(() {
      if (stored.isEmpty) {
        _cells = List.generate(rows * cols, (i) => _TableCell(number: i + 1));
      } else {
        _cells = stored;
      }
    });
  }

  Future<void> _saveTables() async {
    _tableBox ??= await ref.read(hiveServiceProvider).openBox<String>('table_map');
    for (final c in _cells) {
      await _tableBox!.put(c.number.toString(), jsonEncode(c.toMap()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de mesas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _cells.length,
          itemBuilder: (_, i) {
            final c = _cells[i];
            final colorScheme = Theme.of(context).colorScheme;
            final bg = switch (c.status) {
              'libre' => colorScheme.surface,
              'ocupada' => colorScheme.errorContainer,
              'espera' => colorScheme.tertiaryContainer,
              _ => colorScheme.surfaceContainerHighest,
            };
            final fg = switch (c.status) {
              'libre' => Theme.of(context).textTheme.bodyMedium?.color,
              'ocupada' => colorScheme.onErrorContainer,
              'espera' => colorScheme.onTertiaryContainer,
              _ => Theme.of(context).textTheme.bodyMedium?.color,
            };
            return InkWell(
              onTap: () async {
                final picked = await showMenu<String>(
                  context: context,
                  position: const RelativeRect.fromLTRB(200, 200, 200, 200),
                  items: const [
                    PopupMenuItem(value: 'libre', child: Text('Libre')),
                    PopupMenuItem(value: 'ocupada', child: Text('Ocupada')),
                    PopupMenuItem(value: 'espera', child: Text('En espera')),
                  ],
                );
                if (picked != null) {
                  setState(() => c.status = picked);
                  _saveTables();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Mesa ${c.number}', style: TextStyle(color: fg)),
                      const SizedBox(height: 6),
                      Text(c.status.toUpperCase(), style: TextStyle(color: fg, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TableCell {
  _TableCell({required this.number, this.status = 'libre'});
  final int number;
  String status;

  Map<String, dynamic> toMap() => {
        'number': number,
        'status': status,
      };

  factory _TableCell.fromMap(Map<String, dynamic> map) => _TableCell(
        number: map['number'] as int,
        status: map['status'] as String? ?? 'libre',
      );
}


