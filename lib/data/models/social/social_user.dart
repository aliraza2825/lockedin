class SocialUser {
  final String id;
  final String name;
  final String username;
  final String profileImageUrl;
  final String bio;
  final bool isOnline;
  final bool isFriend;
  final int mutualFriends;
  final DateTime lastSeen;
  final String location;

  SocialUser({
    required this.id,
    required this.name,
    required this.username,
    required this.profileImageUrl,
    required this.bio,
    required this.isOnline,
    required this.isFriend,
    required this.mutualFriends,
    required this.lastSeen,
    required this.location,
  });

  factory SocialUser.fromJson(Map<String, dynamic> json) {
    return SocialUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      bio: json['bio'] ?? '',
      isOnline: json['isOnline'] ?? false,
      isFriend: json['isFriend'] ?? false,
      mutualFriends: json['mutualFriends'] ?? 0,
      lastSeen: DateTime.parse(
        json['lastSeen'] ?? DateTime.now().toIso8601String(),
      ),
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'isOnline': isOnline,
      'isFriend': isFriend,
      'mutualFriends': mutualFriends,
      'lastSeen': lastSeen.toIso8601String(),
      'location': location,
    };
  }

  SocialUser copyWith({
    String? id,
    String? name,
    String? username,
    String? profileImageUrl,
    String? bio,
    bool? isOnline,
    bool? isFriend,
    int? mutualFriends,
    DateTime? lastSeen,
    String? location,
  }) {
    return SocialUser(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      isOnline: isOnline ?? this.isOnline,
      isFriend: isFriend ?? this.isFriend,
      mutualFriends: mutualFriends ?? this.mutualFriends,
      lastSeen: lastSeen ?? this.lastSeen,
      location: location ?? this.location,
    );
  }
}
