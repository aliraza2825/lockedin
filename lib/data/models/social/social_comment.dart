class SocialComment {
  final String id;
  final String postId;
  final String userId;
  final String userName;
  final String userProfileImageUrl;
  final String content;
  final DateTime createdAt;
  final int likesCount;
  final bool isLiked;
  final List<String> tags;
  final String? parentCommentId; // For replies
  final List<SocialComment> replies;

  SocialComment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userProfileImageUrl,
    required this.content,
    required this.createdAt,
    required this.likesCount,
    required this.isLiked,
    required this.tags,
    this.parentCommentId,
    required this.replies,
  });

  factory SocialComment.fromJson(Map<String, dynamic> json) {
    return SocialComment(
      id: json['id'] ?? '',
      postId: json['postId'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userProfileImageUrl: json['userProfileImageUrl'] ?? '',
      content: json['content'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      likesCount: json['likesCount'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      tags: List<String>.from(json['tags'] ?? []),
      parentCommentId: json['parentCommentId'],
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map((reply) => SocialComment.fromJson(reply))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'userId': userId,
      'userName': userName,
      'userProfileImageUrl': userProfileImageUrl,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'likesCount': likesCount,
      'isLiked': isLiked,
      'tags': tags,
      'parentCommentId': parentCommentId,
      'replies': replies.map((reply) => reply.toJson()).toList(),
    };
  }

  SocialComment copyWith({
    String? id,
    String? postId,
    String? userId,
    String? userName,
    String? userProfileImageUrl,
    String? content,
    DateTime? createdAt,
    int? likesCount,
    bool? isLiked,
    List<String>? tags,
    String? parentCommentId,
    List<SocialComment>? replies,
  }) {
    return SocialComment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImageUrl: userProfileImageUrl ?? this.userProfileImageUrl,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likesCount: likesCount ?? this.likesCount,
      isLiked: isLiked ?? this.isLiked,
      tags: tags ?? this.tags,
      parentCommentId: parentCommentId ?? this.parentCommentId,
      replies: replies ?? this.replies,
    );
  }
}
