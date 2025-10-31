import 'dart:convert';

import 'package:hive/hive.dart';

class OfflinePayload {
  OfflinePayload({
    required this.id,
    required this.endpoint,
    required this.method,
    required this.body,
    required this.createdAt,
  });

  final String id;
  final String endpoint;
  final String method;
  final Map<String, dynamic> body;
  final DateTime createdAt;

  Map<String, dynamic> toMap() => {
        'id': id,
        'endpoint': endpoint,
        'method': method,
        'body': body,
        'createdAt': createdAt.toIso8601String(),
      };

  factory OfflinePayload.fromMap(Map<String, dynamic> map) => OfflinePayload(
        id: map['id'] as String,
        endpoint: map['endpoint'] as String,
        method: map['method'] as String,
        body: Map<String, dynamic>.from(map['body'] as Map),
        createdAt: DateTime.parse(map['createdAt'] as String),
      );
}

class OfflineQueueService {
  OfflineQueueService(this._box);

  final Box<String> _box;

  static const boxName = 'offline_queue';

  Future<void> enqueue(OfflinePayload payload) async {
    await _box.put(payload.id, jsonEncode(payload.toMap()));
  }

  Future<List<OfflinePayload>> getPending() async {
    return _box.values
        .map((encoded) =>
            OfflinePayload.fromMap(jsonDecode(encoded) as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  Future<void> remove(String id) => _box.delete(id);

  Future<void> clear() => _box.clear();
}

