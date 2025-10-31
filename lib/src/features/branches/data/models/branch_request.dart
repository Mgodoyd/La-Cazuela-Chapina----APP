class BranchRequest {
  BranchRequest({
    required this.name,
    required this.address,
    required this.phone,
  });

  final String name;
  final String address;
  final String phone;

  Map<String, dynamic> toJson() => {
    'Name': name,
    'Address': address,
    'Phone': phone,
  };
}
