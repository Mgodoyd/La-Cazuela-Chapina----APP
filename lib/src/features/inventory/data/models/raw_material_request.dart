class RawMaterialRequest {
  RawMaterialRequest({
    required this.name,
    required this.unit,
    required this.minStock,
  });

  final String name;
  final String unit;
  final double minStock;

  Map<String, dynamic> toJson() => {
    'name': name,
    'unit': unit,
    'minStock': minStock,
  };
}
