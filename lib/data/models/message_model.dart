import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime sentAt;

  MessageModel({
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.sentAt,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'] ?? '',
      chatId: map['chatId'] ?? '',
      senderId: map['senderId'] ?? '',
      content: map['content'] ?? '',
      sentAt:
          map['sentAt'] != null
              ? (map['sentAt'] as Timestamp).toDate()
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'chatId': chatId,
      'senderId': senderId,
      'content': content,
      'sentAt': Timestamp.fromDate(sentAt),
    };
  }

  String get displayContent {
    return content;
  }

  MessageModel copyWith({
    String? messageId,
    String? chatId,
    String? senderId,
    String? content,
    DateTime? sentAt,
    Map<String, DateTime>? readBy,
  }) {
    return MessageModel(
      messageId: messageId ?? this.messageId,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      sentAt: sentAt ?? this.sentAt,
    );
  }
}
