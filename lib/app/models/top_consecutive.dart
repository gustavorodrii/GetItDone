class TopConsecutive {
  final String? id;
  final String name;
  final String? email;
  final int? consecutiveDays;

  TopConsecutive({
    this.id,
    required this.name,
    this.email,
    this.consecutiveDays,
  });

  factory TopConsecutive.fromJson(Map<String, dynamic> json) {
    return TopConsecutive(
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

  TopConsecutive copyWith({
    String? id,
    String? name,
    String? email,
    int? consecutiveDays,
  }) {
    return TopConsecutive(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      consecutiveDays: consecutiveDays ?? this.consecutiveDays,
    );
  }
}
