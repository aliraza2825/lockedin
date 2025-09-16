class SocialPost {
  final String id;
  final String userId;
  final String userName;
  final String userProfileImageUrl;
  final String content;
  final String description;
  final String? imageUrl;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final String location;
  final List<String> tags;
  final bool anonymous;
  final String? pairedUserId;
  final String? pairedUserName;
  final String? pairedUserProfileImageUrl;

  SocialPost({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userProfileImageUrl,
    required this.content,
    required this.description,
    this.imageUrl,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
    required this.location,
    required this.tags,
    required this.anonymous,
    this.pairedUserId,
    this.pairedUserName,
    this.pairedUserProfileImageUrl,
  });

  factory SocialPost.fromJson(Map<String, dynamic> json) {
    return SocialPost(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userProfileImageUrl: json['userProfileImageUrl'] ?? '',
      content: json['content'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      location: json['location'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      anonymous: json['anonymous'] ?? false,
      pairedUserId: json['pairedUserId'],
      pairedUserName: json['pairedUserName'],
      pairedUserProfileImageUrl: json['pairedUserProfileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userProfileImageUrl': userProfileImageUrl,
      'content': content,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'isLiked': isLiked,
      'location': location,
      'tags': tags,
      'anonymous': anonymous,
      'pairedUserId': pairedUserId,
      'pairedUserName': pairedUserName,
      'pairedUserProfileImageUrl': pairedUserProfileImageUrl,
    };
  }

  SocialPost copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userProfileImageUrl,
    String? content,
    String? description,
    String? imageUrl,
    DateTime? createdAt,
    int? likesCount,
    int? commentsCount,
    bool? isLiked,
    String? location,
    List<String>? tags,
    bool? anonymous,
    String? pairedUserId,
    String? pairedUserName,
    String? pairedUserProfileImageUrl,
  }) {
    return SocialPost(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImageUrl: userProfileImageUrl ?? this.userProfileImageUrl,
      content: content ?? this.content,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
      location: location ?? this.location,
      tags: tags ?? this.tags,
      anonymous: anonymous ?? this.anonymous,
      pairedUserId: pairedUserId ?? this.pairedUserId,
      pairedUserName: pairedUserName ?? this.pairedUserName,
      pairedUserProfileImageUrl:
          pairedUserProfileImageUrl ?? this.pairedUserProfileImageUrl,
    );
  }
}
