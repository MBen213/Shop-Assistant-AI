class StoreSettings {
  final String storeName;
  final String address;
  final String phone;
  final String email;
  final String currency;
  final double taxPercentage;
  final String receiptFooter;
  final String? logoPath;

  const StoreSettings({
    required this.storeName,
    required this.address,
    required this.phone,
    required this.email,
    required this.currency,
    required this.taxPercentage,
    required this.receiptFooter,
    this.logoPath,
  });

  StoreSettings copyWith({
    String? storeName,
    String? address,
    String? phone,
    String? email,
    String? currency,
    double? taxPercentage,
    String? receiptFooter,
    String? logoPath,
  }) {
    return StoreSettings(
      storeName: storeName ?? this.storeName,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      currency: currency ?? this.currency,
      taxPercentage: taxPercentage ?? this.taxPercentage,
      receiptFooter: receiptFooter ?? this.receiptFooter,
      logoPath: logoPath ?? this.logoPath,
    );
  }

  factory StoreSettings.empty() {
    return const StoreSettings(
      storeName: "SHOP ASSISTANT AI",
      address: "",
      phone: "",
      email: "",
      currency: "DZD",
      taxPercentage: 0,
      receiptFooter: "Thank you for your purchase",
      logoPath: null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "storeName": storeName,
      "address": address,
      "phone": phone,
      "email": email,
      "currency": currency,
      "taxPercentage": taxPercentage,
      "receiptFooter": receiptFooter,
      "logoPath": logoPath,
    };
  }

  factory StoreSettings.fromMap(
    Map<String, dynamic> map,
  ) {
    return StoreSettings(
      storeName: map["storeName"] ?? "",
      address: map["address"] ?? "",
      phone: map["phone"] ?? "",
      email: map["email"] ?? "",
      currency: map["currency"] ?? "DZD",
      taxPercentage:
          (map["taxPercentage"] ?? 0).toDouble(),
      receiptFooter:
          map["receiptFooter"] ??
              "Thank you for your purchase",
      logoPath: map["logoPath"],
    );
  }
}