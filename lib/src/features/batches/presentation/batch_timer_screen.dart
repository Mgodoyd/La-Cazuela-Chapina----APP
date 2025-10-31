import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../core/storage/hive_providers.dart';

class BatchTimerScreen extends ConsumerStatefulWidget {
  const BatchTimerScreen({super.key});

  @override
  ConsumerState<BatchTimerScreen> createState() => _BatchTimerScreenState();
}

class _BatchTimerScreenState extends ConsumerState<BatchTimerScreen> {
  final List<_Batch> _batches = [];
  Box<String>? _batchBox;

  @override
  void initState() {
    super.initState();
    _loadBatches();
  }

  Future<void> _loadBatches() async {
    final hiveService = ref.read(hiveServiceProvider);
    _batchBox = await hiveService.openBox<String>('batch_timers');
    if (!mounted) return;
    final stored = _batchBox!.values
        .map((json) => _Batch.fromMap(jsonDecode(json) as Map<String, dynamic>))
        .toList();
    setState(() => _batches.addAll(stored));
  }

  Future<void> _saveBatch(_Batch batch) async {
    _batchBox ??= await ref.read(hiveServiceProvider).openBox<String>('batch_timers');
    await _batchBox!.put(batch.name, jsonEncode(batch.toMap()));
  }

  Future<void> _deleteBatch(_Batch batch) async {
    _batchBox ??= await ref.read(hiveServiceProvider).openBox<String>('batch_timers');
    await _batchBox!.delete(batch.name);
  }

  void _addBatch() async {
    final ctrl = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuevo lote'),
        content: TextField(controller: ctrl, decoration: const InputDecoration(labelText: 'Nombre del lote')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(ctx, ctrl.text.trim()), child: const Text('Crear')),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;
    final batch = _Batch(name: name);
    setState(() => _batches.add(batch));
    await _saveBatch(batch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cronometraje de lotes')),
      floatingActionButton: FloatingActionButton(onPressed: _addBatch, child: const Icon(Icons.add_rounded)),
      body: ListView.separated(
        itemCount: _batches.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, i) => _BatchTile(
          batch: _batches[i],
          onDelete: () async {
            await _deleteBatch(_batches[i]);
            setState(() => _batches.removeAt(i));
          },
        ),
      ),
    );
  }
}

class _BatchTile extends ConsumerStatefulWidget {
  const _BatchTile({required this.batch, required this.onDelete});
  final _Batch batch;
  final VoidCallback onDelete;

  @override
  ConsumerState<_BatchTile> createState() => _BatchTileState();
}

class _BatchTileState extends ConsumerState<_BatchTile> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.batch.running) _start();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _start() async {
    _timer?.cancel();
    widget.batch.running = true;
    _saveBatchToStorage();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        widget.batch.elapsed++;
        if (widget.batch.elapsed % 5 == 0) _saveBatchToStorage(); // guardar cada 5 segundos
      });
    });
  }

  Future<void> _pause() async {
    widget.batch.running = false;
    _timer?.cancel();
    await _saveBatchToStorage();
    setState(() {});
  }

  Future<void> _reset() async {
    widget.batch.running = false;
    widget.batch.elapsed = 0;
    _timer?.cancel();
    await _saveBatchToStorage();
    setState(() {});
  }

  Future<void> _saveBatchToStorage() async {
    try {
      final hiveService = ref.read(hiveServiceProvider);
      final box = await hiveService.openBox<String>('batch_timers');
      await box.put(widget.batch.name, jsonEncode(widget.batch.toMap()));
    } catch (_) {
      // ignorar errores de storage
    }
  }

  @override
  Widget build(BuildContext context) {
    final e = Duration(seconds: widget.batch.elapsed);
    final h = e.inHours.toString().padLeft(2, '0');
    final m = (e.inMinutes % 60).toString().padLeft(2, '0');
    final s = (e.inSeconds % 60).toString().padLeft(2, '0');
    return ListTile(
      title: Text(widget.batch.name),
      subtitle: Text('$h:$m:$s'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: widget.batch.running ? 'Pausar' : 'Iniciar',
            icon: Icon(widget.batch.running ? Icons.pause_rounded : Icons.play_arrow_rounded),
            onPressed: widget.batch.running ? _pause : _start,
          ),
          IconButton(
            tooltip: 'Reiniciar',
            icon: const Icon(Icons.restart_alt_rounded),
            onPressed: _reset,
          ),
          IconButton(
            tooltip: 'Eliminar',
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: widget.onDelete,
          ),
        ],
      ),
    );
  }
}

class _Batch {
  _Batch({required this.name, this.elapsed = 0, this.running = false});
  final String name;
  int elapsed;
  bool running;

  Map<String, dynamic> toMap() => {
        'name': name,
        'elapsed': elapsed,
        'running': running,
      };

  factory _Batch.fromMap(Map<String, dynamic> map) => _Batch(
        name: map['name'] as String,
        elapsed: map['elapsed'] as int? ?? 0,
        running: map['running'] as bool? ?? false,
      );
}


