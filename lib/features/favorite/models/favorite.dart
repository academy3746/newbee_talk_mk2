/// Favorite Model Class
class FavoriteModel {
  final int? id;

  final int foodStoreId;

  final String favoriteUid;

  final DateTime? createdAt;

  FavoriteModel({
    this.id,
    required this.foodStoreId,
    required this.favoriteUid,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'food_store_id': foodStoreId,
      'favorite_uid': favoriteUid,
    };
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> data) {
    return FavoriteModel(
      id: data['id'],
      foodStoreId: data['food_store_id'],
      favoriteUid: data['favorite_uid'],
      createdAt: DateTime.parse(data['created_at']),
    );
  }
}
