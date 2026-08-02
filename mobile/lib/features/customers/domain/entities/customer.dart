class Customer {
  final String id;
  final String name;
  final String phone;
  final String? address;
  final String? notes;
  final double debt;

  const Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.address,
    this.notes,
    this.debt = 0,
  });

  Customer copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    String? notes,
    double? debt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      debt: debt ?? this.debt,
    );
  }
}