import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locked_in/app/config/app_colors.dart';
import 'package:locked_in/app/config/app_text_styles.dart';
import 'package:locked_in/data/models/social/social_user.dart';
import 'package:locked_in/data/models/social/social_post.dart';
import 'package:sizer/sizer.dart';
import '../controllers/social_controller.dart';

class SocialView extends GetView<SocialController> {
  const SocialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'Social',
          style: AppTextStyles.heading.copyWith(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showAddPostBottomSheet,
            icon: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ],
        bottom: TabBar(
          controller: controller.tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: AppTextStyles.bodyTextBold.copyWith(
            fontSize: 14.sp,
            color: Colors.white,
          ),
          tabs: const [Tab(text: 'Feed'), Tab(text: 'Friends')],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [_buildFeedTab(), _buildFriendsTab(context)],
      ),
    );
  }

  Widget _buildFriendsTab(BuildContext context) {
    return Column(
      children: [
        // Search bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: AppColors.grey200, width: 0.5),
            ),
          ),
          child: TextField(
            controller: controller.searchController,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            onChanged: controller.updateSearchQuery,
            decoration: InputDecoration(
              hintText: 'Search friends...',
              hintStyle: AppTextStyles.bodyText400.copyWith(
                fontSize: 12.sp,
                color: AppColors.grey400,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.grey500,
                size: 20.sp,
              ),
              suffixIcon: Obx(
                () =>
                    controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: AppColors.grey500,
                            size: 18.sp,
                          ),
                          onPressed: () {
                            controller.searchController.clear();
                            controller.updateSearchQuery('');
                          },
                        )
                        : const SizedBox.shrink(),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: AppColors.grey300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: AppColors.grey300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: 1.5.h,
              ),
              filled: true,
              fillColor: AppColors.grey100,
            ),
          ),
        ),
        // Friends list
        Expanded(
          child: Obx(() {
            final filteredFriends = controller.getFilteredFriends();
            return filteredFriends.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_search,
                        color: AppColors.grey400,
                        size: 50.sp,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        controller.searchQuery.value.isEmpty
                            ? 'No friends yet'
                            : 'No friends found',
                        style: AppTextStyles.bodyText400.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.grey500,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        controller.searchQuery.value.isEmpty
                            ? 'Start adding friends to see them here'
                            : 'Try searching with a different name',
                        style: AppTextStyles.bodyText400.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.grey400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
                : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  itemCount: filteredFriends.length,
                  itemBuilder: (context, index) {
                    final user = filteredFriends[index];
                    return _buildUserCard(user);
                  },
                );
          }),
        ),
      ],
    );
  }

  Widget _buildUserCard(SocialUser user) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile image
          Stack(
            children: [
              CircleAvatar(
                radius: 6.w,
                backgroundImage: CachedNetworkImageProvider(
                  user.profileImageUrl,
                ),
              ),
              if (user.isOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 3.w,
                    height: 3.w,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 3.w),

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: AppTextStyles.bodyTextBold.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  user.username,
                  style: AppTextStyles.bodyText400.copyWith(
                    fontSize: 11.sp,
                    color: AppColors.grey500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.3.h),
                Text(
                  user.bio,
                  style: AppTextStyles.bodyText400.copyWith(
                    fontSize: 10.sp,
                    color: AppColors.grey400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.3.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 10.sp,
                      color: AppColors.grey400,
                    ),
                    SizedBox(width: 0.5.w),
                    Expanded(
                      child: Text(
                        user.location,
                        style: AppTextStyles.bodyText400.copyWith(
                          fontSize: 9.sp,
                          color: AppColors.grey400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (user.mutualFriends > 0) ...[
                      SizedBox(width: 1.w),
                      Text(
                        '${user.mutualFriends} mutual',
                        style: AppTextStyles.bodyText400.copyWith(
                          fontSize: 9.sp,
                          color: AppColors.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Action button
          SizedBox(
            width: 16.w,
            height: 4.h,
            child: ElevatedButton(
              onPressed: () {
                if (user.isFriend) {
                  controller.removeFriend(user.id);
                } else {
                  controller.addFriend(user.id);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    user.isFriend ? AppColors.grey300 : AppColors.primary,
                foregroundColor:
                    user.isFriend ? AppColors.grey500 : Colors.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                elevation: 0,
              ),
              child: Text(
                user.isFriend ? 'Friends' : 'Add',
                style: AppTextStyles.bodyTextBold.copyWith(
                  fontSize: 9.sp,
                  color: user.isFriend ? AppColors.grey500 : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedTab() {
    return Column(
      children: [
        // Filter bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: AppColors.grey200, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.filter_list, color: AppColors.grey500, size: 18.sp),
              SizedBox(width: 2.w),
              Text(
                'Filter:',
                style: AppTextStyles.bodyTextBold.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.grey500,
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All'),
                      SizedBox(width: 2.w),
                      _buildFilterChip('My Posts'),
                      SizedBox(width: 2.w),
                      _buildFilterChip('Other Posts'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Posts list
        Expanded(
          child: Obx(() {
            final filteredPosts = controller.getFilteredPosts();
            return filteredPosts.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.post_add,
                        color: AppColors.grey400,
                        size: 50.sp,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'No posts found',
                        style: AppTextStyles.bodyText400.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.grey500,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Try changing the filter or create a new post',
                        style: AppTextStyles.bodyText400.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.grey400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
                : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filteredPosts.length,
                  itemBuilder: (context, index) {
                    final post = filteredPosts[index];
                    return _buildPostCard(post);
                  },
                );
          }),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String filter) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.selectedFilter.value = filter,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color:
                controller.selectedFilter.value == filter
                    ? AppColors.primary
                    : AppColors.grey100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:
                  controller.selectedFilter.value == filter
                      ? AppColors.primary
                      : AppColors.grey300,
              width: 1,
            ),
          ),
          child: Text(
            filter,
            style: AppTextStyles.bodyTextBold.copyWith(
              fontSize: 11.sp,
              color:
                  controller.selectedFilter.value == filter
                      ? Colors.white
                      : AppColors.grey500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostCard(SocialPost post) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile picture
              CircleAvatar(
                radius: 5.w,
                backgroundImage: CachedNetworkImageProvider(
                  post.userProfileImageUrl,
                ),
              ),
              SizedBox(width: 3.w),

              // Content area
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User interaction text
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: post.userName,
                            style: AppTextStyles.bodyTextBold.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ' ${post.content}',
                            style: AppTextStyles.bodyText400.copyWith(
                              fontSize: 13.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 0.8.h),

                    // Description
                    Text(
                      post.description,
                      style: AppTextStyles.bodyText400.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.grey500,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 1.2.h),

                    // Action buttons
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => controller.toggleLike(post.id),
                          child: Row(
                            children: [
                              Icon(
                                post.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    post.isLiked
                                        ? Colors.red
                                        : AppColors.grey500,
                                size: 15.sp,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                'Like',
                                style: AppTextStyles.bodyText400.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColors.grey500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 4.w),
                        GestureDetector(
                          onTap:
                              () => controller.openCommentBottomSheet(post.id),
                          child: Row(
                            children: [
                              Icon(
                                Icons.comment_outlined,
                                color: AppColors.grey500,
                                size: 15.sp,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                'Comment',
                                style: AppTextStyles.bodyText400.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColors.grey500,
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

              // Timestamp and more options
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    controller.getTimeAgo(post.createdAt),
                    style: AppTextStyles.bodyText400.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.grey500,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Icon(Icons.more_vert, color: AppColors.grey500, size: 18.sp),
                ],
              ),
            ],
          ),
        ),
        // Divider
        Container(
          height: 0.5,
          color: AppColors.grey200,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
        ),
      ],
    );
  }

  void _showAddPostBottomSheet() {
    Get.bottomSheet(
      _buildAddPostBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  Widget _buildAddPostBottomSheet() {
    return Container(
      height: Get.height * 0.75,
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
            'Create New Post',
            style: AppTextStyles.headingExtraLarge.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Post content input
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User profile section
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 5.w,
                        backgroundImage: const CachedNetworkImageProvider(
                          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You',
                            style: AppTextStyles.bodyTextBold.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Share your payment activity',
                            style: AppTextStyles.bodyText400.copyWith(
                              fontSize: 11.sp,
                              color: AppColors.grey500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),

                  // Payment description input
                  Text(
                    'What\'s on your mind?',
                    style: AppTextStyles.bodyTextBold.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  TextField(
                    controller: controller.descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Describe what you\'re thinking...',
                      hintStyle: AppTextStyles.bodyText400.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.grey400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.grey300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.grey300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 2.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Privacy section
                  Text(
                    'Who can see this post?',
                    style: AppTextStyles.bodyTextBold.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),

                  // Privacy dropdown
                  Obx(
                    () => Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedPrivacy.value,
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.grey500,
                            size: 20.sp,
                          ),
                          style: AppTextStyles.bodyText400.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.black,
                          ),
                          items: [
                            DropdownMenuItem<String>(
                              value: 'Public',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.public,
                                    color: AppColors.grey500,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text('Public'),
                                ],
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Friends',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    color: AppColors.grey500,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text('Friends'),
                                ],
                              ),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Only Me',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    color: AppColors.grey500,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text('Only Me'),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.selectedPrivacy.value = newValue;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: AppColors.grey300),
                  ),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.bodyTextBold.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.grey500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => controller.createPost(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Post',
                    style: AppTextStyles.bodyTextBold.copyWith(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
