class PairedUser {
  final String id;
  final String userAId;
  final String userAName;
  final String userAProfileImageUrl;
  final String userBId;
  final String userBName;
  final String userBProfileImageUrl;
  final DateTime pairedAt;
  final String status; // "Active", "Expired", "Pending"
  final String? location;
  final String? description;

  PairedUser({
    required this.id,
    required this.userAId,
    required this.userAName,
    required this.userAProfileImageUrl,
    required this.userBId,
    required this.userBName,
    required this.userBProfileImageUrl,
    required this.pairedAt,
    required this.status,
    this.location,
    this.description,
  });

  factory PairedUser.fromJson(Map<String, dynamic> json) {
    return PairedUser(
      id: json['id'] ?? '',
      userAId: json['userAId'] ?? '',
      userAName: json['userAName'] ?? '',
      userAProfileImageUrl: json['userAProfileImageUrl'] ?? '',
      userBId: json['userBId'] ?? '',
      userBName: json['userBName'] ?? '',
      userBProfileImageUrl: json['userBProfileImageUrl'] ?? '',
      pairedAt: DateTime.parse(
        json['pairedAt'] ?? DateTime.now().toIso8601String(),
      ),
      status: json['status'] ?? 'Active',
      location: json['location'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userAId': userAId,
      'userAName': userAName,
      'userAProfileImageUrl': userAProfileImageUrl,
      'userBId': userBId,
      'userBName': userBName,
      'userBProfileImageUrl': userBProfileImageUrl,
      'pairedAt': pairedAt.toIso8601String(),
      'status': status,
      'location': location,
      'description': description,
    };
  }

  PairedUser copyWith({
    String? id,
    String? userAId,
    String? userAName,
    String? userAProfileImageUrl,
    String? userBId,
    String? userBName,
    String? userBProfileImageUrl,
    DateTime? pairedAt,
    String? status,
    String? location,
    String? description,
  }) {
    return PairedUser(
      id: id ?? this.id,
      userAId: userAId ?? this.userAId,
      userAName: userAName ?? this.userAName,
      userAProfileImageUrl: userAProfileImageUrl ?? this.userAProfileImageUrl,
      userBId: userBId ?? this.userBId,
      userBName: userBName ?? this.userBName,
      userBProfileImageUrl: userBProfileImageUrl ?? this.userBProfileImageUrl,
      pairedAt: pairedAt ?? this.pairedAt,
      status: status ?? this.status,
      location: location ?? this.location,
      description: description ?? this.description,
    );
  }
}
