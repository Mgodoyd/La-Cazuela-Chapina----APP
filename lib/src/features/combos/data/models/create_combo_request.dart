class CreateComboRequest {
  final String name;
  final String description;
  final double price;
  final bool editable;
  final List<ComboProductRequest> products;

  CreateComboRequest({
    required this.name,
    required this.description,
    required this.price,
    required this.editable,
    required this.products,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'editable': editable,
        'products': products.map((p) => p.toJson()).toList(),
      };
}

class ComboProductRequest {
  final String productId;
  final int quantity;

  ComboProductRequest({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
      };
}

