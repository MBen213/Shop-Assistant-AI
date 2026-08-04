class User {
  final String id;
  final String username;
  final String passwordHash;
  final String fullName;
  final String role;
  final bool isActive;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.username,
    required this.passwordHash,
    required this.fullName,
    required this.role,
    required this.isActive,
    required this.createdAt,
  });

  bool get isOwner => role == 'owner';

  bool get isManager => role == 'manager';

  bool get isCashier => role == 'cashier';

  User copyWith({
    String? id,
    String? username,
    String? passwordHash,
    String? fullName,
    String? role,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}