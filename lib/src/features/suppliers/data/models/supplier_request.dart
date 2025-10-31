class SupplierRequest {
  SupplierRequest({
    required this.name,
    required this.contact,
    required this.phone,
  });

  final String name;
  final String contact;
  final String phone;

  Map<String, dynamic> toJson() => {
    'Name': name,
    'Contact': contact,
    'Phone': phone,
  };
}
