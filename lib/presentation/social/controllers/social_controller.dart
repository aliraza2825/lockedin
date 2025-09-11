import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:locked_in/data/models/social/social_user.dart';
import 'package:locked_in/data/models/social/social_post.dart';
import 'package:locked_in/data/models/social/social_comment.dart';
import 'package:locked_in/data/models/social/paired_user.dart';

class SocialController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final RxInt selectedTabIndex = 0.obs;
  final RxList<SocialUser> users = <SocialUser>[].obs;
  final RxList<SocialPost> posts = <SocialPost>[].obs;
  final RxList<SocialComment> comments = <SocialComment>[].obs;
  final RxList<PairedUser> pairedUsers = <PairedUser>[].obs;
  final RxString selectedPostId = ''.obs;
  final TextEditingController commentController = TextEditingController();
  final RxList<String> selectedTags = <String>[].obs;

  // Add post controllers
  final TextEditingController descriptionController = TextEditingController();
  final RxString selectedPrivacy = 'Public'.obs;

  // Feed filter
  final RxString selectedFilter = 'All'.obs;

  // Friends search
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });
    _loadDummyData();
  }

  @override
  void onClose() {
    tabController.dispose();
    commentController.dispose();
    descriptionController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void _loadDummyData() {
    // Dummy users data
    users.addAll([
      SocialUser(
        id: '1',
        name: 'Sarah Johnson',
        username: '@sarahj',
        profileImageUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        bio: 'Love traveling and photography 📸',
        isOnline: true,
        isFriend: true,
        mutualFriends: 12,
        lastSeen: DateTime.now().subtract(const Duration(minutes: 5)),
        location: 'New York, NY',
      ),
      SocialUser(
        id: '2',
        name: 'Mike Chen',
        username: '@mikechen',
        profileImageUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        bio: 'Tech enthusiast and coffee lover ☕',
        isOnline: false,
        isFriend: false,
        mutualFriends: 8,
        lastSeen: DateTime.now().subtract(const Duration(hours: 2)),
        location: 'San Francisco, CA',
      ),
      SocialUser(
        id: '3',
        name: 'Emma Davis',
        username: '@emmad',
        profileImageUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        bio: 'Artist and nature lover 🌿',
        isOnline: true,
        isFriend: true,
        mutualFriends: 15,
        lastSeen: DateTime.now().subtract(const Duration(minutes: 30)),
        location: 'Los Angeles, CA',
      ),
      SocialUser(
        id: '4',
        name: 'Alex Rodriguez',
        username: '@alexr',
        profileImageUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        bio: 'Fitness coach and motivational speaker 💪',
        isOnline: false,
        isFriend: false,
        mutualFriends: 3,
        lastSeen: DateTime.now().subtract(const Duration(days: 1)),
        location: 'Miami, FL',
      ),
      SocialUser(
        id: '5',
        name: 'Lisa Wang',
        username: '@lisaw',
        profileImageUrl:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
        bio: 'Food blogger and chef 👩‍🍳',
        isOnline: true,
        isFriend: false,
        mutualFriends: 6,
        lastSeen: DateTime.now().subtract(const Duration(minutes: 10)),
        location: 'Seattle, WA',
      ),
      SocialUser(
        id: '6',
        name: 'David Kim',
        username: '@davidk',
        profileImageUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
        bio: 'Music producer and DJ 🎵',
        isOnline: false,
        isFriend: true,
        mutualFriends: 20,
        lastSeen: DateTime.now().subtract(const Duration(hours: 4)),
        location: 'Austin, TX',
      ),
    ]);

    // Dummy payment activities data (matching reference image)
    posts.addAll([
      SocialPost(
        id: '1',
        userId: '1',
        userName: 'Hallie R',
        userProfileImageUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        content: 'pair Maret M',
        description: 'gameday buttons',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        likesCount: 12,
        commentsCount: 3,
        isLiked: false,
        location: '',
        tags: [],
      ),
      SocialPost(
        id: '2',
        userId: '2',
        userName: 'Kevin H',
        userProfileImageUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        content: 'pair Michael M',
        description: 'Silly bills',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        likesCount: 8,
        commentsCount: 1,
        isLiked: true,
        location: '',
        tags: [],
      ),
      SocialPost(
        id: '3',
        userId: '3',
        userName: 'Kristina B',
        userProfileImageUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        content: 'pair Annette L',
        description: 'TV',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        likesCount: 15,
        commentsCount: 2,
        isLiked: false,
        location: '',
        tags: [],
      ),
      SocialPost(
        id: '4',
        userId: '4',
        userName: 'Elliott G',
        userProfileImageUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        content: 'pair Liam G',
        description: '💦☔️🔥',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        likesCount: 22,
        commentsCount: 5,
        isLiked: true,
        location: '',
        tags: [],
      ),
      SocialPost(
        id: '5',
        userId: '5',
        userName: 'Adam L',
        userProfileImageUrl:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
        content: 'pair Tunde A',
        description: 'Lucern train',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        likesCount: 7,
        commentsCount: 1,
        isLiked: false,
        location: '',
        tags: [],
      ),
      SocialPost(
        id: '6',
        userId: '6',
        userName: 'Jessie L',
        userProfileImageUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
        content: 'pair Justin L',
        description: 'Sailing away down a dragons 🐉',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        likesCount: 18,
        commentsCount: 4,
        isLiked: true,
        location: '',
        tags: [],
      ),
    ]);

    // Dummy comments data
    comments.addAll([
      SocialComment(
        id: '1',
        postId: '1',
        userId: '2',
        userName: 'Mike Chen',
        userProfileImageUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        content: 'That looks absolutely delicious! 😋 #foodie #jealous',
        createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
        likesCount: 5,
        isLiked: false,
        tags: ['foodie', 'jealous'],
        replies: [],
      ),
      SocialComment(
        id: '2',
        postId: '1',
        userId: '3',
        userName: 'Emma Davis',
        userProfileImageUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        content:
            'I need to try this place! What\'s the name? #recommendation #food',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        likesCount: 3,
        isLiked: true,
        tags: ['recommendation', 'food'],
        replies: [],
      ),
    ]);

    // Dummy paired users data
    pairedUsers.addAll([
      PairedUser(
        id: '1',
        userAId: 'current_user',
        userAName: 'You',
        userAProfileImageUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        userBId: '1',
        userBName: 'Sarah Johnson',
        userBProfileImageUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        pairedAt: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'Active',
        location: 'Central Park, NYC',
        description: 'Met at the coffee shop and decided to pair up!',
      ),
      PairedUser(
        id: '2',
        userAId: '3',
        userAName: 'Emma Davis',
        userAProfileImageUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        userBId: '4',
        userBName: 'Alex Rodriguez',
        userBProfileImageUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        pairedAt: DateTime.now().subtract(const Duration(days: 1)),
        status: 'Active',
        location: 'Art Gallery, LA',
        description: 'Connected through mutual love for art',
      ),
      PairedUser(
        id: '3',
        userAId: '5',
        userAName: 'Lisa Wang',
        userAProfileImageUrl:
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
        userBId: '6',
        userBName: 'David Kim',
        userBProfileImageUrl:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
        pairedAt: DateTime.now().subtract(const Duration(hours: 6)),
        status: 'Active',
        location: 'Music Studio, Austin',
        description: 'Food and music collaboration',
      ),
      PairedUser(
        id: '4',
        userAId: '2',
        userAName: 'Mike Chen',
        userAProfileImageUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
        userBId: '7',
        userBName: 'Jessica Lee',
        userBProfileImageUrl:
            'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
        pairedAt: DateTime.now().subtract(const Duration(days: 3)),
        status: 'Expired',
        location: 'Tech Conference, SF',
        description: 'Met at the tech conference',
      ),
    ]);
  }

  void toggleLike(String postId) {
    final postIndex = posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      final post = posts[postIndex];
      posts[postIndex] = post.copyWith(
        isLiked: !post.isLiked,
        likesCount: post.isLiked ? post.likesCount - 1 : post.likesCount + 1,
      );
    }
  }

  void addFriend(String userId) {
    final userIndex = users.indexWhere((user) => user.id == userId);
    if (userIndex != -1) {
      users[userIndex] = users[userIndex].copyWith(isFriend: true);
    }
  }

  void removeFriend(String userId) {
    final userIndex = users.indexWhere((user) => user.id == userId);
    if (userIndex != -1) {
      users[userIndex] = users[userIndex].copyWith(isFriend: false);
    }
  }

  void openCommentBottomSheet(String postId) {
    selectedPostId.value = postId;
    selectedTags.clear();
    commentController.clear();
    Get.bottomSheet(
      _buildCommentBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  Widget _buildCommentBottomSheet() {
    final postComments = getCommentsForPost(selectedPostId.value);

    return Container(
      height: Get.height * 0.8,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            'Comments (${postComments.length})',
            style: Get.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Comments list
          Expanded(
            child:
                postComments.isEmpty
                    ? Center(
                      child: Text(
                        'No comments yet. Be the first to comment!',
                        style: Get.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                    : ListView.builder(
                      itemCount: postComments.length,
                      itemBuilder: (context, index) {
                        final comment = postComments[index];
                        return _buildCommentItem(comment);
                      },
                    ),
          ),

          const SizedBox(height: 20),

          // Add comment section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add a comment',
                  style: Get.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                // Comment input
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Write your comment...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Get.theme.primaryColor),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 12),

                // Tags section
                Text(
                  'Tags',
                  style: Get.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                // Available tags
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children:
                      [
                            'thanks',
                            'awesome',
                            'great',
                            'fun',
                            'amazing',
                            'cool',
                            'nice',
                            'perfect',
                          ]
                          .map(
                            (tag) => Obx(
                              () => FilterChip(
                                label: Text(
                                  tag,
                                  style: TextStyle(fontSize: 12),
                                ),
                                selected: selectedTags.contains(tag),
                                onSelected: (selected) {
                                  if (selected) {
                                    selectedTags.add(tag);
                                  } else {
                                    selectedTags.remove(tag);
                                  }
                                },
                                selectedColor: Get.theme.primaryColor
                                    .withOpacity(0.2),
                                checkmarkColor: Get.theme.primaryColor,
                                labelStyle: TextStyle(
                                  color:
                                      selectedTags.contains(tag)
                                          ? Get.theme.primaryColor
                                          : Colors.grey[700],
                                  fontWeight:
                                      selectedTags.contains(tag)
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 16),

                // Post button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (commentController.text.isNotEmpty) {
                        _addComment();
                        commentController.clear();
                        selectedTags.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.theme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Post Comment',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(SocialComment comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile picture
          CircleAvatar(
            radius: 16,
            backgroundImage: CachedNetworkImageProvider(
              comment.userProfileImageUrl,
            ),
          ),
          const SizedBox(width: 12),

          // Comment content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User name and time
                Row(
                  children: [
                    Text(
                      comment.userName,
                      style: Get.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      getTimeAgo(comment.createdAt),
                      style: Get.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Comment text
                Text(comment.content, style: Get.textTheme.bodyMedium),

                // Tags if any
                if (comment.tags.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children:
                        comment.tags
                            .map(
                              (tag) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Get.theme.primaryColor.withOpacity(
                                    0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '#$tag',
                                  style: TextStyle(
                                    color: Get.theme.primaryColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ],

                const SizedBox(height: 8),

                // Like button
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _toggleCommentLike(comment.id),
                      child: Row(
                        children: [
                          Icon(
                            comment.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                comment.isLiked ? Colors.red : Colors.grey[600],
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            comment.likesCount > 0
                                ? comment.likesCount.toString()
                                : '',
                            style: Get.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleCommentLike(String commentId) {
    final commentIndex = comments.indexWhere(
      (comment) => comment.id == commentId,
    );
    if (commentIndex != -1) {
      final comment = comments[commentIndex];
      comments[commentIndex] = comment.copyWith(
        isLiked: !comment.isLiked,
        likesCount:
            comment.isLiked ? comment.likesCount - 1 : comment.likesCount + 1,
      );
    }
  }

  void _addComment() {
    if (commentController.text.isNotEmpty) {
      final newComment = SocialComment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        postId: selectedPostId.value,
        userId: 'current_user',
        userName: 'You',
        userProfileImageUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        content: commentController.text,
        createdAt: DateTime.now(),
        likesCount: 0,
        isLiked: false,
        tags: selectedTags.toList(),
        replies: [],
      );

      comments.add(newComment);

      // Update post comment count
      final postIndex = posts.indexWhere(
        (post) => post.id == selectedPostId.value,
      );
      if (postIndex != -1) {
        posts[postIndex] = posts[postIndex].copyWith(
          commentsCount: posts[postIndex].commentsCount + 1,
        );
      }
    }
  }

  List<SocialComment> getCommentsForPost(String postId) {
    return comments.where((comment) => comment.postId == postId).toList();
  }

  List<SocialPost> getFilteredPosts() {
    switch (selectedFilter.value) {
      case 'My Posts':
        return posts.where((post) => post.userId == 'current_user').toList();
      case 'Other Posts':
        return posts.where((post) => post.userId != 'current_user').toList();
      case 'All':
      default:
        return posts.toList();
    }
  }

  List<SocialUser> getFilteredFriends() {
    if (searchQuery.value.isEmpty) {
      return users.toList();
    }
    return users
        .where(
          (user) =>
              user.name.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ||
              user.username.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ),
        )
        .toList();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }

  void createPost() {
    if (descriptionController.text.isNotEmpty) {
      final newPost = SocialPost(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'current_user',
        userName: 'You',
        userProfileImageUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        content: 'shared a post',
        description: descriptionController.text,
        createdAt: DateTime.now(),
        likesCount: 0,
        commentsCount: 0,
        isLiked: false,
        location: '',
        tags: [], // Empty tags since tags section was removed
      );

      // Add to beginning of posts list
      posts.insert(0, newPost);

      // Clear form
      descriptionController.clear();
      selectedPrivacy.value = 'Public';

      // Close bottom sheet
      Get.back();

      // Show success message
      Get.snackbar(
        'Success',
        'Post created successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } else {
      // Show error message
      Get.snackbar(
        'Error',
        'Please write something to post',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
