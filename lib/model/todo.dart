class TodoField {
  static const createdTime = "createdTime";
}

class Todo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  Todo({
    required this.title,
    required this.createdTime,
    required this.id,
    this.description = " ",
    this.isDone = false,
  });

  // implement a copyWith method
  Todo copyWith({
    String? title,
    DateTime? createdTime,
    String? description,
    String? id,
    bool? isDone,
  }) {
    return Todo(
      title: title ?? this.title,
      createdTime: createdTime ?? this.createdTime,
      description: description ?? this.description,
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
    );
  }
}
