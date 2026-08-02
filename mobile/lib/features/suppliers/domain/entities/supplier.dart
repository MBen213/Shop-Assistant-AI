class Supplier {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String email;

  const Supplier({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });

  Supplier copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    String? email,
  }) {
    return Supplier(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      email: email ?? this.email,
    );
  }
}