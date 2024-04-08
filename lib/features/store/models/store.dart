class FoodStore {
  final int? id;

  final String? storeImgUrl;

  final String storeAddress;

  final String storeName;

  final String storeInfo;

  final String uid;

  final String latitude;

  final String longitude;

  final DateTime? createdAt;

  FoodStore({
    this.id,
    required this.storeImgUrl,
    required this.storeAddress,
    required this.storeName,
    required this.storeInfo,
    required this.uid,
    required this.latitude,
    required this.longitude,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'store_img_url': storeImgUrl,
      'store_address': storeAddress,
      'store_name': storeName,
      'store_info': storeInfo,
      'uid': uid,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory FoodStore.fromJson(Map<String, dynamic> data) {
    return FoodStore(
      id: data['id'],
      storeImgUrl: data['store_img_url'],
      storeAddress: data['store_address'],
      storeName: data['store_name'],
      storeInfo: data['store_info'],
      uid: data['uid'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      createdAt: DateTime.parse(data['created_at']),
    );
  }
}
