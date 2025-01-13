class UserModel {
  String id;
  String? message;
  String email;
  String name;
  String? password;

  UserModel({
    required this.id,
    this.message,
    required this.email,
    required this.name,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      message: json['message'] ?? '',
      email: json['email'],
      name: json['name'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message ?? '',
        'email': email,
        'name': name,
        'password': password,
      };
}
