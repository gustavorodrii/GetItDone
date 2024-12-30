class TodoModel {
  final String? id;
  final String title;
  final String? description;
  bool completed;
  final DateTime? reminder;
  final DateTime? createdAt;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.reminder,
    this.createdAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
      reminder:
          json['reminder'] != null ? DateTime.parse(json['reminder']) : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'reminder': reminder?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
