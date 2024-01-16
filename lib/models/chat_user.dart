class ChatUser {
  ChatUser({
    required this.id,
    required this.image,
    required this.name,
    required this.about,
    required this.isOnline,
    required this.lastActive,
    required this.createAt,
    required this.email,
    required this.pushToken,
  });
  late  String id;
  late  String image;
  late  String name;
  late  String about;
  late  bool isOnline;
  late  String lastActive;
  late  String createAt;
  late  String email;
  late  String pushToken;

  ChatUser.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? '';
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    about = json['about'] ?? '';
    isOnline = json['is_online'] ?? '';
    lastActive = json['last_active'] ?? '';
    createAt = json['create_at'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['about'] = about;
    data['is_online'] = isOnline;
    data['last_active'] = lastActive;
    data['create_at'] = createAt;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }
}