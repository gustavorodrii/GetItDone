class UserModel {
  String id;
  String? message;
  String email;
  String name;

  UserModel(
      {required this.id,
      this.message,
      required this.email,
      required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      message: json['message'] ?? '',
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message ?? '',
        'email': email,
        'name': name,
      };
}
