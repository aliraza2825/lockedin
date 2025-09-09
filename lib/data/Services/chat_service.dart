import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_courier/app/config/app_enums.dart';
import 'package:medical_courier/app/config/global_var.dart';
import 'package:medical_courier/data/models/chat_model.dart';
import 'package:medical_courier/data/models/message_model.dart';
import 'package:uuid/uuid.dart';
import 'package:medical_courier/presentation/dispatchers_list/controllers/dispatchers_list_controller.dart';
import 'package:medical_courier/data/models/dispatcher.dart';
import 'package:medical_courier/data/provider/local_storage/local_db.dart';
import 'package:medical_courier/app/config/local_keys.dart';

class ChatService extends GetxService with WidgetsBindingObserver {
  static ChatService get instance => Get.find<ChatService>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;
  final Uuid _uuid = const Uuid();

  // Collection names
  static const String _chatsCollection = 'chats';
  static const String _messagesCollection = 'messages';

  // Current user info - using existing app patterns
  String get currentUserId => Globals.userId.toString();

  /// Unregister ChatService when user logs out
  static void unregisterOnLogout() {
    try {
      if (Get.isRegistered<ChatService>()) {
        log('Unregistering ChatService after user logout');
        Get.delete<ChatService>();
      }
    } catch (e) {
      log('Error unregistering ChatService: $e');
    }
  }

  // Generate chat ID without creating the chat document
  String generateChatId({
    required List<int> participantIds,
    required ChatType chatType,
  }) {
    if (chatType == ChatType.individual) {
      // For individual chats, create a consistent ID from participant IDs
      List<int> sortedIds = List<int>.from(participantIds);
      sortedIds.sort(); // Sort numerically for consistency
      return '${sortedIds[0]}_${sortedIds[1]}';
    } else {
      // For group chats, generate a unique ID
      return _uuid.v4();
    }
  }

  // Get user's chats stream
  Stream<List<ChatModel>> getUserChats() {
    return _firestore
        .collection(_chatsCollection)
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) {
          List<ChatModel> chats = [];
          for (QueryDocumentSnapshot doc in snapshot.docs) {
            try {
              ChatModel chat = ChatModel.fromMap(
                doc.data() as Map<String, dynamic>,
              );
              chats.add(chat);
            } catch (e) {
              log('Error parsing chat document ${doc.id}: $e');
              // Skip malformed documents instead of breaking the entire stream
              continue;
            }
          }
          return chats;
        })
        .handleError((error) {
          log('Error in getUserChats stream: $error');
          return <ChatModel>[]; // Return empty list on error
        });
  }

  // Send message
  Future<void> sendMessage({
    required String chatId,
    required String content,
    List<int>? participantIds,
    ChatType? chatType,
  }) async {
    try {
      // Create chat document if it doesn't exist
      await _createChatIfNotExists(chatId, participantIds, chatType);

      // Create message
      MessageModel message = MessageModel(
        messageId: '',
        chatId: chatId,
        senderId: currentUserId,
        content: content,
        sentAt: DateTime.now(),
      );

      // Add message to Firestore
      DocumentReference messageRef = await _firestore
          .collection(_chatsCollection)
          .doc(chatId)
          .collection(_messagesCollection)
          .add(message.toMap());

      // Update message with generated ID
      message = message.copyWith(messageId: messageRef.id);

      // Update chat's last message
      await _updateChatLastMessage(chatId, message);

      log('Message sent successfully: ${message.messageId}');
    } catch (e) {
      log('Error sending message: $e');
      rethrow;
    }
  }

  // Create chat document if it doesn't exist
  Future<void> _createChatIfNotExists(
    String chatId,
    List<int>? participantIds,
    ChatType? chatType,
  ) async {
    try {
      // Check if chat already exists
      DocumentSnapshot chatDoc =
          await _firestore.collection(_chatsCollection).doc(chatId).get();

      if (!chatDoc.exists) {
        List<String> participants =
            participantIds?.map((id) => id.toString()).toList() ?? [];
        participants.sort(); // Sort for consistency

        // Get participant names
        Map<String, String> participantNames = {};
        if (participantIds != null) {
          for (int participantId in participantIds) {
            String name = await _getParticipantName(participantId);
            participantNames[participantId.toString()] = name;
          }
        }

        if (chatType == ChatType.individual) {
          // Create new individual chat
          await _firestore.collection(_chatsCollection).doc(chatId).set({
            'chatId': chatId,
            'chatType': ChatType.individual.name,
            'participants': participants,
            'participantNames': participantNames,
            'createdAt': FieldValue.serverTimestamp(),
            'lastMessage': '',
            'lastMessageTime': FieldValue.serverTimestamp(),
            'lastMessageSenderId': '',
          });
        } else {
          // Create new group chat
          await _firestore.collection(_chatsCollection).doc(chatId).set({
            'chatId': chatId,
            'chatType': ChatType.group.name,
            'participants': participants,
            'participantNames': participantNames,
            'groupName': 'Group Chat',
            'groupImage': '',
            'createdAt': FieldValue.serverTimestamp(),
            'createdBy': currentUserId,
            'lastMessage': '',
            'lastMessageTime': FieldValue.serverTimestamp(),
            'lastMessageSenderId': '',
            'admins': [currentUserId],
          });
        }
      }
    } catch (e) {
      log('Error creating chat: $e');
      rethrow;
    }
  }

  // Get participant name from various sources
  Future<String> _getParticipantName(int participantId) async {
    // If it's the current user (technician)
    if (participantId.toString() == currentUserId) {
      log(
        'Getting current user name. fullName: "${Globals.fullName}", userId: $currentUserId',
      );

      // Try to get name from various sources
      if (Globals.fullName.isNotEmpty) {
        return Globals.fullName;
      }

      // If fullName is empty, construct a name from firstName and userId
      String firstName =
          await LocalDB.getData(LocalDataKey.firstName.name) ?? "";
      if (firstName.isNotEmpty) {
        return firstName;
      }

      // If firstName is also empty, use a generic name with userId
      return 'Technician ${Globals.userId}';
    }

    // For dispatchers (web users), try to get from dispatchers list controller
    try {
      if (Get.isRegistered<DispatchersListController>()) {
        final dispatchersController = Get.find<DispatchersListController>();
        final dispatcher = dispatchersController.dispatchers.firstWhere(
          (d) => d.userId == participantId,
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

    // Fallback to generic dispatcher name
    return 'Dispatcher $participantId';
  }

  // Get chat messages stream
  Stream<List<MessageModel>> getChatMessages(String chatId) {
    return _firestore
        .collection(_chatsCollection)
        .doc(chatId)
        .collection(_messagesCollection)
        .orderBy('sentAt', descending: true)
        .snapshots()
        .map((snapshot) {
          List<MessageModel> messages = [];
          for (QueryDocumentSnapshot doc in snapshot.docs) {
            try {
              MessageModel message = MessageModel.fromMap(
                doc.data() as Map<String, dynamic>,
              );
              messages.add(message);
            } catch (e) {
              log('Error parsing message document ${doc.id}: $e');
              // Skip malformed documents instead of breaking the entire stream
              continue;
            }
          }
          return messages;
        })
        .handleError((error) {
          log('Error in getChatMessages stream: $error');
          return <MessageModel>[]; // Return empty list on error
        });
  }

  // Get last message for status checking (more efficient)
  Stream<MessageModel?> getLastMessage(String chatId) {
    return _firestore
        .collection(_chatsCollection)
        .doc(chatId)
        .collection(_messagesCollection)
        .orderBy('sentAt', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) return null;

          try {
            return MessageModel.fromMap(snapshot.docs.first.data());
          } catch (e) {
            log('Error parsing last message document: $e');
            return null;
          }
        })
        .handleError((error) {
          log('Error in getLastMessage stream: $error');
          return null;
        });
  }

  // Private helper methods
  Future<void> _updateChatLastMessage(
    String chatId,
    MessageModel message,
  ) async {
    try {
      await _firestore.collection(_chatsCollection).doc(chatId).update({
        'lastMessage': message.content,
        'lastMessageTime': FieldValue.serverTimestamp(),
        'lastMessageSenderId': message.senderId,
      });
    } catch (e) {
      log('Error updating chat last message: $e');
    }
  }
}
