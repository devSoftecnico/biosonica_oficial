class UserModel {
  final String displayName;
  final String email;
  final DateTime registrationDate;
  final DateTime? lastLoginDate;
  final DateTime? lastLogoutDate;
  final bool status;
  final String role;
  final String subscription;
  final double totalView;
  final String? photoUrl;

  UserModel({
    required this.displayName,
    required this.email,
    required this.registrationDate,
    this.lastLoginDate,
    this.lastLogoutDate,
    this.status = true,
    this.role = 'Usuario',
    this.subscription = 'Radio',
    this.totalView = 0.0,
    this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      registrationDate: DateTime.parse(json['registrationDate'] as String),
      lastLoginDate: json['lastLoginDate'] != null ? DateTime.parse(json['lastLoginDate'] as String) : null,
      lastLogoutDate: json['lastLogoutDate'] != null ? DateTime.parse(json['lastLogoutDate'] as String) : null,
      status: json['status'] as bool? ?? true,
      role: json['role'] as String? ?? 'Usuario',
      subscription: json['subscription'] as String? ?? 'Radio',
      totalView: (json['totalView'] as num?)?.toDouble() ?? 0.0,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'registrationDate': registrationDate.toIso8601String(),
      'lastLoginDate': lastLoginDate?.toIso8601String(),
      'lastLogoutDate': lastLogoutDate?.toIso8601String(),
      'status': status,
      'role': role,
      'subscription': subscription,
      'totalView': totalView,
      'photoUrl': photoUrl,
    };
  }

  UserModel copyWith({
    String? displayName,
    String? email,
    DateTime? registrationDate,
    DateTime? lastLoginDate,
    DateTime? lastLogoutDate,
    bool? status,
    String? role,
    String? subscription,
    double? totalView,
    String? photoUrl,
  }) {
    return UserModel(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      registrationDate: registrationDate ?? this.registrationDate,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      lastLogoutDate: lastLogoutDate ?? this.lastLogoutDate,
      status: status ?? this.status,
      role: role ?? this.role,
      subscription: subscription ?? this.subscription,
      totalView: totalView ?? this.totalView,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
