import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:locked_in/app/config/app_colors.dart';
import 'package:locked_in/app/config/app_text_styles.dart';
import 'package:locked_in/app/shared_widgets/background_simple.dart';
import 'package:locked_in/data/models/chat_model.dart';
import 'package:locked_in/data/Services/chat_service.dart';
import 'package:sizer/sizer.dart';
import '../controllers/chat_controller.dart';
import 'package:locked_in/app/routes/app_pages.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundSimpleWidget(
      child: Scaffold(
        backgroundColor: AppColors.trans,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          elevation: 1,
          title: Center(child: Text("Chats".tr, style: AppTextStyles.heading)),
          bottom: TabBar(
            controller: controller.tabController,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            tabs: const [Tab(text: "Dispatcher Chat"), Tab(text: "Order Chat")],
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [
            // Dispatcher Chat Tab
            _buildDispatcherChatList(),
            // Order Chat Tab
            _buildOrderChatList(),
          ],
        ),
      ),
    );
  }

  /// 📋 Dispatcher Chat List
  Widget _buildDispatcherChatList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return controller.individualChats.isEmpty
          ? _buildEmptyState(
            icon: Icons.chat_bubble_outline,
            title: 'No Dispatcher Chats',
            subtitle:
                'Start a conversation with a dispatcher from the dispatchers list',
            actionText: 'Go to Dispatchers',
            onAction: () {
              Get.toNamed(Routes.DISPATCHERS_LIST);
            },
          )
          : ListView.builder(
            shrinkWrap: true,
            itemCount: controller.individualChats.length,
            itemBuilder: (context, index) {
              final chat = controller.individualChats[index];
              return _buildChatListItem(chat);
            },
          );
    });
  }

  /// 📋 Order Chat List
  Widget _buildOrderChatList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return controller.groupChats.isEmpty
          ? _buildEmptyState(
            icon: Icons.group_outlined,
            title: 'No Order Chats',
            subtitle: 'Order chats will appear here when you accept orders',
            actionText: null,
            onAction: null,
          )
          : ListView.builder(
            shrinkWrap: true,
            itemCount: controller.groupChats.length,
            itemBuilder: (context, index) {
              final chat = controller.groupChats[index];
              return _buildChatListItem(chat);
            },
          );
    });
  }

  /// 📭 Empty State Widget
  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    String? actionText,
    VoidCallback? onAction,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 12.w, color: AppColors.primary),
            ),
            SizedBox(height: 3.h),
            Text(
              title,
              style: AppTextStyles.bodyTextBold.copyWith(
                fontSize: 16.sp,
                color: AppColors.darkPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              subtitle,
              maxLines: 2,
              style: AppTextStyles.bodyText.copyWith(
                fontSize: 12.sp,

                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onAction != null) ...[
              SizedBox(height: 3.h),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: Icon(Icons.arrow_forward, size: 16.sp),
                label: Text(actionText),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  textStyle: AppTextStyles.bodyText.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// 📝 Chat List Item
  Widget _buildChatListItem(ChatModel chat) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primary,
        child: Text(
          chat.isGroupChat
              ? (chat.groupName?.substring(0, 1).toUpperCase() ?? 'G')
              : chat
                  .getOtherParticipantName(ChatService.instance.currentUserId)
                  .substring(0, 1)
                  .toUpperCase(),
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        chat.isGroupChat
            ? chat.groupName ?? 'Order Chat'
            : chat.getOtherParticipantName(ChatService.instance.currentUserId),
        style: AppTextStyles.bodyTextBold,
      ),
      subtitle: Text(
        chat.displayLastMessage,
        style: AppTextStyles.bodyText.copyWith(
          color: Colors.grey[600],
          fontSize: 11.sp,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('HH:mm').format(chat.lastMessageTime),
            style: AppTextStyles.small.copyWith(
              color: Colors.grey[500],
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
      onTap: () {
        controller.openChatRoom(chat);
      },
    ).paddingSymmetric(horizontal: 4.w, vertical: 1.h);
  }
}
