import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locked_in/app/config/app_enums.dart';
import 'package:locked_in/app/routes/app_pages.dart';
import 'package:locked_in/app/utils/utils.dart';
import 'package:locked_in/data/Services/chat_service.dart';
import 'package:locked_in/data/models/chat_model.dart';

class ChatController extends GetxController with GetTickerProviderStateMixin {
  // Tab controller for chat tabs
  late TabController tabController;

  // Observable variables
  final isLoading = false.obs;

  // Chat lists
  final individualChats = <ChatModel>[].obs;
  final groupChats = <ChatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeTabController();
    _initializeChatService();
    _listenToUserChats();
  }

  void _initializeTabController() {
    tabController = TabController(length: 2, vsync: this);
  }

  void _initializeChatService() {
    if (!Get.isRegistered<ChatService>()) {
      Get.put(ChatService());
    }
  }

  void _listenToUserChats() {
    // Set loading to true when starting to fetch chats
    isLoading.value = true;

    ChatService.instance.getUserChats().listen(
      (chats) {
        // Separate individual and group chats
        individualChats.clear();
        groupChats.clear();

        for (ChatModel chat in chats) {
          if (chat.chatType == ChatType.individual) {
            individualChats.add(chat);
          } else {
            groupChats.add(chat);
          }
        }

        // Set loading to false when chats are loaded
        isLoading.value = false;
      },
      onError: (error) {
        // Set loading to false on error
        isLoading.value = false;

        // Only show error snackbar for serious errors, not for missing documents
        if (!error.toString().contains('not-found') &&
            !error.toString().contains('Null') &&
            !error.toString().contains('type cast')) {
          Utils.showToast(message: 'Error loading chats: Please try again');
        }
      },
    );
  }

  // Open chat room
  void openChatRoom(ChatModel chat) {
    Map<String, dynamic> arguments = {
      'chatId': chat.chatId,
      'chatType': chat.chatType,
      'chat': chat,
    };

    if (chat.chatType == ChatType.individual) {
      String otherUserId = chat.getOtherParticipantId(
        ChatService.instance.currentUserId,
      );
      arguments['otherUserId'] = int.tryParse(otherUserId) ?? 0;
    }

    Get.toNamed(Routes.CHAT_ROOM, arguments: arguments);
  }

  // Create dispatcher chat (navigate without creating chat document)
  Future<void> createDispatcherChat(String dispatcherId) async {
    try {
      // Check if a chat already exists with this dispatcher
      ChatModel? existingChat;
      for (ChatModel chat in individualChats) {
        if (chat.chatType == ChatType.individual) {
          String otherUserId = chat.getOtherParticipantId(
            ChatService.instance.currentUserId,
          );
          if (otherUserId == dispatcherId) {
            existingChat = chat;
            break;
          }
        }
      }

      // Navigate to chat room with arguments
      Map<String, dynamic> arguments = {
        'chatType': ChatType.individual,
        'otherUserId': int.parse(dispatcherId),
      };

      // If existing chat found, pass it along
      if (existingChat != null) {
        arguments['chatId'] = existingChat.chatId;
        arguments['chat'] = existingChat;
      }

      Get.toNamed(Routes.CHAT_ROOM, arguments: arguments);
    } catch (e) {
      log('Error creating dispatcher chat: $e');
      Utils.showToast(message: 'Failed to create chat');
    }
  }

  // Join order chat (navigate without creating chat document)
  Future<void> joinOrderChat(String orderId, String groupName) async {
    try {
      // Navigate to chat room with arguments (no chat ID created yet)
      Map<String, dynamic> arguments = {
        'chatType': ChatType.group,
        'groupName': groupName,
        'orderId': orderId,
      };

      Get.toNamed(Routes.CHAT_ROOM, arguments: arguments);
    } catch (e) {
      log('Error joining order chat: $e');
      Utils.showToast(message: 'Failed to join order chat');
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
