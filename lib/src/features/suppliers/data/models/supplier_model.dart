class SupplierModel {
  SupplierModel({
    required this.id,
    required this.name,
    required this.contact,
    required this.phone,
  });

  final String id;
  final String name;
  final String contact;
  final String phone;

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    String read(String primary, String fallback) {
      final value = json[primary] ?? json[fallback];
      if (value == null) return '';
      return value.toString();
    }

    return SupplierModel(
      id: read('Id', 'id'),
      name: read('Name', 'name'),
      contact: read('Contact', 'contact'),
      phone: read('Phone', 'phone'),
    );
  }

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Name': name,
    'Contact': contact,
    'Phone': phone,
  };

  SupplierModel copyWith({
    String? id,
    String? name,
    String? contact,
    String? phone,
  }) {
    return SupplierModel(
      id: id ?? this.id,
      name: name ?? this.name,
      contact: contact ?? this.contact,
      phone: phone ?? this.phone,
    );
  }
}
