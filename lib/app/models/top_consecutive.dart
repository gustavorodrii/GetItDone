class TopConsecutive {
  final ActualUser? actualUser;
  final List<AllUsers>? allUsers;

  TopConsecutive({
    this.actualUser,
    this.allUsers,
  });

  factory TopConsecutive.fromJson(Map<String, dynamic> json) {
    return TopConsecutive(
      actualUser: json['actualUser'] != null
          ? ActualUser.fromJson(json['actualUser'])
          : null, // Mapear o 'actualUser'
      allUsers: json['allUsers'] != null
          ? (json['allUsers'] as List)
              .map((user) => AllUsers.fromJson(user))
              .toList()
          : [], // Mapear os 'allUsers'
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actualUser': actualUser?.toJson(), // Salvar o 'actualUser'
      'allUsers': allUsers?.map((user) => user.toJson()).toList(),
    };
  }

  TopConsecutive copyWith({
    ActualUser? actualUser,
    List<AllUsers>? allUsers,
  }) {
    return TopConsecutive(
      actualUser: actualUser ?? this.actualUser,
      allUsers: allUsers ?? this.allUsers,
    );
  }
}

class ActualUser {
  final String? id;
  final String? name;
  final String? email;
  final int? consecutiveDays;

  ActualUser({
    this.id,
    this.name,
    this.email,
    this.consecutiveDays,
  });

  factory ActualUser.fromJson(Map<String, dynamic> json) {
    return ActualUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      consecutiveDays: json['consecutiveDays'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'consecutiveDays': consecutiveDays,
    };
  }

  ActualUser copyWith({
    String? id,
    String? name,
    String? email,
    int? consecutiveDays,
  }) {
    return ActualUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      consecutiveDays: consecutiveDays ?? this.consecutiveDays,
    );
  }
}

class AllUsers {
  final String? id;
  final String? name;
  final String? email;
  final int? consecutiveDays;

  AllUsers({
    this.id,
    this.name,
    this.email,
    this.consecutiveDays,
  });

  factory AllUsers.fromJson(Map<String, dynamic> json) {
    return AllUsers(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      consecutiveDays: json['consecutiveDays'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'consecutiveDays': consecutiveDays,
    };
  }

  AllUsers copyWith({
    String? id,
    String? name,
    String? email,
    int? consecutiveDays,
  }) {
    return AllUsers(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      consecutiveDays: consecutiveDays ?? this.consecutiveDays,
    );
  }
}
