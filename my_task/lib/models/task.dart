class Task {
  final String id;
  final String title;
  final bool done;

  Task({
    required this.id,
    required this.title,
    this.done = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'done': done ? 1 : 0,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'].toString(),
      title: json['title'],
      done: json['done'] == 1 || json['done'] == true,
    );
  }

  Task copyWith({String? id, String? title, bool? done}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
    );
  }
}