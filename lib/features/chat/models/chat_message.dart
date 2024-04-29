class ChatMessageModel {
  final int? id;

  final String message;

  final String uid;

  final String? profileUrl;

  final int chatRoomId;

  final String name;

  final DateTime? createdAt;

  ChatMessageModel({
    this.id,
    required this.message,
    required this.uid,
    required this.profileUrl,
    required this.chatRoomId,
    required this.name,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'uid': uid,
      'profile_url': profileUrl,
      'chat_room_id': chatRoomId,
      'name': name,
    };
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> data) {
    return ChatMessageModel(
      id: data['id'],
      message: data['message'],
      uid: data['uid'],
      profileUrl: data['profile_url'],
      chatRoomId: data['chat_room_id'],
      name: data['name'],
      createdAt: DateTime.parse(data['created_at']),
    );
  }
}
