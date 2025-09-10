import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:locked_in/app/config/app_colors.dart';
import 'package:locked_in/app/config/app_text_styles.dart';
import 'package:locked_in/app/shared_widgets/background_simple.dart';
import 'package:locked_in/data/models/message_model.dart';
import 'package:sizer/sizer.dart';
import '../controllers/chat_room_controller.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundSimpleWidget(
      child: Scaffold(
        backgroundColor: AppColors.trans,
        appBar: _buildAppBar(),
        body: Column(
          children: [
            // Messages
            Expanded(child: _buildMessagesList()),
            // Message Input
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  /// 📱 App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primary),
        onPressed: () => Get.back(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.getChatTitle(),
            style: AppTextStyles.bodyTextBold.copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  /// 📝 Messages List
  Widget _buildMessagesList() {
    return Obx(() {
      if (controller.messages.isEmpty) {
        return _buildEmptyMessagesState();
      }

      return ListView.builder(
        controller: controller.scrollController,
        itemCount: controller.messages.length,
        reverse: true,
        itemBuilder: (context, index) {
          final message = controller.messages[index];
          return Column(
            children: [
              // Show timestamp if needed
              if (controller.shouldShowTimestamp(index))
                _buildTimestampDivider(message.sentAt),
              // Message bubble
              _buildMessageBubble(message, index),
            ],
          );
        },
      );
    });
  }

  /// 📅 Timestamp Divider
  Widget _buildTimestampDivider(DateTime timestamp) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              DateFormat('MMM dd, yyyy').format(timestamp),
              style: AppTextStyles.small.copyWith(
                color: Colors.grey[600],
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 💬 Empty Messages State
  Widget _buildEmptyMessagesState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 60.sp, color: Colors.grey[400]),
          SizedBox(height: 2.h),
          Text(
            'No messages yet',
            style: AppTextStyles.bodyText.copyWith(
              color: Colors.grey[600],
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            'Start a conversation!',
            style: AppTextStyles.small.copyWith(
              color: Colors.grey[500],
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  /// 💬 Message Bubble
  Widget _buildMessageBubble(MessageModel message, int index) {
    final isMyMessage = controller.isMyMessage(message);
    final shouldShowSenderName = controller.shouldShowSenderName(index);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMyMessage) ...[
            CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.primary,
              child: Text(
                shouldShowSenderName ? 'U' : '',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 2.w),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: isMyMessage ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Show sender name for group chats
                  if (shouldShowSenderName && !isMyMessage)
                    Padding(
                      padding: EdgeInsets.only(bottom: 0.5.h),
                      child: Text(
                        controller.getParticipantName(message.senderId),
                        style: AppTextStyles.small.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  // Message content
                  Text(
                    message.displayContent,
                    style: AppTextStyles.bodyText.copyWith(
                      color: isMyMessage ? AppColors.white : AppColors.black,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  // Message time and status
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(message.sentAt),
                        style: AppTextStyles.small.copyWith(
                          color:
                              isMyMessage
                                  ? AppColors.white.withValues(alpha: 0.7)
                                  : Colors.grey[500],
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isMyMessage) ...[
            SizedBox(width: 2.w),
            CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.primary,
              child: Text(
                'Me',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// ✏️ Message Input
  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          // Input row
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.messageController,
                  onChanged: (value) {
                    controller.canSend.value = value.isNotEmpty;
                  },
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  cursorColor: AppColors.primary,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    fillColor: Colors.grey[100],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500],
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              // Send button
              Obx(() {
                return controller.isSendingMessage.value
                    ? const Center(child: CircularProgressIndicator())
                    : GestureDetector(
                      onTap:
                          controller.canSend.value
                              ? controller.sendMessage
                              : null,
                      child: Container(
                        height: Get.width / 8,
                        width: Get.width / 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              controller.canSend.value
                                  ? AppColors.primary
                                  : Colors.grey[300],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.send,
                            color:
                                controller.canSend.value
                                    ? AppColors.white
                                    : Colors.grey[500],
                          ),
                        ),
                      ),
                    );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
