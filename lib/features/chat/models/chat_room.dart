class ChatRoomModel {
  final int? id;

  final List<String> membersUid;

  final DateTime? createdAt;

  ChatRoomModel({
    this.id,
    required this.membersUid,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'members_uid': membersUid,
    };
  }

  factory ChatRoomModel.fromJson(Map<String, dynamic> data) {
    return ChatRoomModel(
      id: data['id'],
      membersUid: List<String>.from(data['members_uid']),
      createdAt: DateTime.parse(data['created_at']),
    );
  }
}
