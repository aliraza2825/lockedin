class UserModel {
  final String userId;
  final String name;
  final String? profileImage;

  UserModel({required this.userId, required this.name, this.profileImage});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      profileImage: map['profileImage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'name': name, 'profileImage': profileImage};
  }

  UserModel copyWith({String? userId, String? name, String? profileImage}) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
