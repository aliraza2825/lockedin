import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medical_courier/app/config/app_enums.dart';
import 'package:medical_courier/app/utils/utils.dart';
import 'package:medical_courier/data/Services/chat_service.dart';
import 'package:medical_courier/data/models/chat_model.dart';
import 'package:medical_courier/data/models/message_model.dart';
import 'package:medical_courier/presentation/dispatchers_list/controllers/dispatchers_list_controller.dart';
import 'package:medical_courier/app/config/global_var.dart';
import 'package:medical_courier/data/models/dispatcher.dart';

class ChatRoomController extends GetxController with WidgetsBindingObserver {
  // Arguments from previous screen
  String? chatId; // Can be null for new chats
  late ChatType chatType;
  ChatModel? chat;
  int? otherUserId;
  String? groupName;
  String? orderId;

  // Controllers
  late TextEditingController messageController;
  late ScrollController scrollController;

  // Observable variables
  final isLoading = false.obs;
  final isSendingMessage = false.obs;
  final messages = <MessageModel>[].obs;
  final canSend = false.obs;

  // New chat tracking
  final isNewChat = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    // Initialize controllers
    messageController = TextEditingController();
    scrollController = ScrollController();

    _initializeArguments();
    _setupListeners();
    _loadMessages();
  }

  void _initializeArguments() {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};

    chatId = arguments['chatId']; // Can be null for new chats
    chatType = arguments['chatType'] ?? ChatType.individual;
    if (arguments.containsKey('chat')) {
      chat = arguments['chat'];
    }
    otherUserId = arguments['otherUserId'];
    groupName = arguments['groupName'];
    orderId = arguments['orderId'];

    // Check if this is a new chat (no chatId provided)
    if (chatId == null || chatId!.isEmpty) {
      isNewChat.value = true;
    }
  }

  void _setupListeners() {
    // Only listen to messages if we have a chatId
    if (chatId != null && chatId!.isNotEmpty) {
      ChatService.instance.getChatMessages(chatId!).listen((messagesList) {
        messages.value = messagesList;
      });
    }
  }

  void _loadMessages() {
    // Only load messages if we have a chatId
    if (chatId != null && chatId!.isNotEmpty) {
      ChatService.instance.getChatMessages(chatId!).listen((messagesList) {
        messages.value = messagesList;
      });
    }
  }

  // Send new text message
  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) {
      return;
    }

    try {
      isSendingMessage.value = true;

      String content = messageController.text.trim();
      messageController.clear();

      // If this is a new chat, create the chat ID first
      if (isNewChat.value || chatId == null || chatId!.isEmpty) {
        await _createNewChat();
      }

      // Send the message
      await ChatService.instance.sendMessage(
        chatId: chatId!,
        content: content,
        participantIds: _getParticipantIds(),
        chatType: chatType,
      );

      // Scroll to bottom after sending
      scrollToBottom();
    } catch (e) {
      log('Error sending message: $e');
      Utils.showToast(message: 'Error sending message');
    } finally {
      isSendingMessage.value = false;
    }
  }

  // Create new chat when first message is sent
  Future<void> _createNewChat() async {
    try {
      if (chatType == ChatType.individual && otherUserId != null) {
        // Create individual chat
        final newChatId = ChatService.instance.generateChatId(
          participantIds: [
            int.parse(ChatService.instance.currentUserId),
            otherUserId!,
          ],
          chatType: ChatType.individual,
        );
        chatId = newChatId;
      } else if (chatType == ChatType.group) {
        // Create group chat
        final newChatId = ChatService.instance.generateChatId(
          participantIds: [int.parse(ChatService.instance.currentUserId)],
          chatType: ChatType.group,
        );
        chatId = newChatId;
      }

      // Mark as no longer a new chat
      isNewChat.value = false;

      // Setup listeners for the new chat
      _setupListeners();
      _loadMessages();
    } catch (e) {
      log('Error creating new chat: $e');
      Utils.showToast(message: 'Error creating chat');
    }
  }

  // Copy message text to clipboard
  void copyMessageText(MessageModel message) {
    if (message.content.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: message.content));
      Utils.showToast(message: 'Message copied to clipboard');
    }
  }

  // Get chat title
  String getChatTitle() {
    if (chatType == ChatType.group) {
      return chat?.groupName ?? 'Order Chat';
    } else {
      // Use stored participant name for dispatcher
      if (chat != null && otherUserId != null) {
        return chat!.getOtherParticipantName(
          ChatService.instance.currentUserId,
        );
      }

      // If chat is null (new chat), try to get dispatcher name from dispatchers list
      if (otherUserId != null) {
        return _getDispatcherName(otherUserId!);
      }

      return 'Dispatcher';
    }
  }

  // Get current user ID
  String get currentUserId => ChatService.instance.currentUserId;

  // Get participant name
  String getParticipantName(String participantId) {
    if (chat != null) {
      return chat!.getParticipantName(participantId);
    }

    // If chat is null, try to get name from dispatchers list
    if (participantId == ChatService.instance.currentUserId) {
      return _getCurrentUserName();
    } else {
      return _getDispatcherName(int.parse(participantId));
    }
  }

  // Get dispatcher name from dispatchers list controller
  String _getDispatcherName(int dispatcherId) {
    try {
      if (Get.isRegistered<DispatchersListController>()) {
        final dispatchersController = Get.find<DispatchersListController>();
        final dispatcher = dispatchersController.dispatchers.firstWhere(
          (d) => d.userId == dispatcherId,
          orElse: () => Dispatcher(),
        );
        if (dispatcher.userId != null) {
          if (dispatcher.firstName != null && dispatcher.lastName != null) {
            return '${dispatcher.firstName} ${dispatcher.lastName}';
          } else if (dispatcher.firstName != null) {
            return dispatcher.firstName!;
          } else if (dispatcher.lastName != null) {
            return dispatcher.lastName!;
          }
        }
      }
    } catch (e) {
      log('Error getting dispatcher name: $e');
    }
    return 'Dispatcher $dispatcherId';
  }

  // Get current user name
  String _getCurrentUserName() {
    if (Globals.fullName.isNotEmpty) {
      return Globals.fullName;
    }
    return 'Technician ${Globals.userId}';
  }

  // Get participant IDs for the chat
  List<int> _getParticipantIds() {
    if (chat != null) {
      return chat!.participants.map((id) => int.parse(id)).toList();
    } else if (chatType == ChatType.individual && otherUserId != null) {
      // For individual chats, include current user and other user
      int currentUserId = int.parse(ChatService.instance.currentUserId);
      return [currentUserId, otherUserId!];
    }
    return [];
  }

  // Check if message is from current user
  bool isMyMessage(MessageModel message) {
    return message.senderId == ChatService.instance.currentUserId;
  }

  // Check if message should show timestamp (only when date changes)
  bool shouldShowTimestamp(int index) {
    // Always show timestamp for the last message (oldest message when reversed)
    if (index == messages.length - 1) return true;

    MessageModel currentMessage = messages[index];
    MessageModel nextMessage = messages[index + 1];

    // Check if the date changed between current and next message
    DateTime currentDate = DateTime(
      currentMessage.sentAt.year,
      currentMessage.sentAt.month,
      currentMessage.sentAt.day,
    );

    DateTime nextDate = DateTime(
      nextMessage.sentAt.year,
      nextMessage.sentAt.month,
      nextMessage.sentAt.day,
    );

    // Show timestamp only when date changes
    return currentDate != nextDate;
  }

  // Check if message should show sender name (for group chats)
  bool shouldShowSenderName(int index) {
    if (chatType == ChatType.individual) return false;
    if (isMyMessage(messages[index])) return false;
    if (index == messages.length - 1) return true;

    MessageModel currentMessage = messages[index];
    MessageModel nextMessage = messages[index + 1];

    return currentMessage.senderId != nextMessage.senderId;
  }

  // Scroll to bottom
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
