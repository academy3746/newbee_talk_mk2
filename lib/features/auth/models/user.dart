/// User Model Class
class UserModel {
  final int? id;

  final String name;

  final String email;

  final String introduce;

  final String? profileUrl;

  final String uid;

  final DateTime? createdAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.introduce,
    required this.profileUrl,
    required this.uid,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'introduce': introduce,
      'profile_url': profileUrl,
      'uid': uid,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      introduce: data['introduce'],
      profileUrl: data['profile_url'],
      uid: data['uid'],
      createdAt: DateTime.parse(data['created_at']),
    );
  }
}
