import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_courier/app/config/app_enums.dart';

class ChatModel {
  final String chatId;
  final ChatType chatType;
  final List<String> participants;
  final Map<String, String> participantNames; // Store participant names
  final String? groupName;
  final DateTime createdAt;
  final String? createdBy;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String lastMessageSenderId;

  ChatModel({
    required this.chatId,
    required this.chatType,
    required this.participants,
    required this.participantNames,
    this.groupName,
    required this.createdAt,
    this.createdBy,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageSenderId,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'] ?? '',
      chatType: ChatType.values.firstWhere(
        (e) => e.name == map['chatType'],
        orElse: () => ChatType.individual,
      ),
      participants: List<String>.from(map['participants'] ?? []),
      participantNames: Map<String, String>.from(map['participantNames'] ?? {}),
      groupName: map['groupName'],
      createdAt:
          map['createdAt'] != null
              ? (map['createdAt'] as Timestamp).toDate()
              : DateTime.now(),
      createdBy: map['createdBy'],
      lastMessage: map['lastMessage'] ?? '',
      lastMessageTime:
          map['lastMessageTime'] != null
              ? (map['lastMessageTime'] as Timestamp).toDate()
              : DateTime.now(),
      lastMessageSenderId: map['lastMessageSenderId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'chatType': chatType.name,
      'participants': participants,
      'participantNames': participantNames,
      'groupName': groupName,
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
      'lastMessage': lastMessage,
      'lastMessageTime': Timestamp.fromDate(lastMessageTime),
      'lastMessageSenderId': lastMessageSenderId,
    };
  }

  // Helper methods
  bool get isGroupChat => chatType == ChatType.group;

  String getOtherParticipantId(String currentUserId) {
    if (chatType == ChatType.individual && participants.length == 2) {
      return participants.firstWhere(
        (id) => id != currentUserId,
        orElse: () => '',
      );
    }
    return '';
  }

  // Get other participant name
  String getOtherParticipantName(String currentUserId) {
    String otherId = getOtherParticipantId(currentUserId);
    if (otherId.isNotEmpty) {
      return participantNames[otherId] ?? 'User';
    }
    return 'User';
  }

  // Get participant name by ID
  String getParticipantName(String participantId) {
    return participantNames[participantId] ?? 'User';
  }

  // Get all participant names except current user
  List<String> getOtherParticipantNames(String currentUserId) {
    return participants
        .where((id) => id != currentUserId)
        .map((id) => participantNames[id] ?? 'User')
        .toList();
  }

  // Display last message
  String get displayLastMessage {
    return lastMessage;
  }

  ChatModel copyWith({
    String? chatId,
    ChatType? chatType,
    List<String>? participants,
    Map<String, String>? participantNames,
    String? groupName,
    DateTime? createdAt,
    String? createdBy,
    String? lastMessage,
    DateTime? lastMessageTime,
    String? lastMessageSenderId,
  }) {
    return ChatModel(
      chatId: chatId ?? this.chatId,
      chatType: chatType ?? this.chatType,
      participants: participants ?? this.participants,
      participantNames: participantNames ?? this.participantNames,
      groupName: groupName ?? this.groupName,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
    );
  }
}
