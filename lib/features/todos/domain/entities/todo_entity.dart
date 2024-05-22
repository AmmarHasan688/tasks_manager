import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  int id;
  String todo;
  bool completed;
  int userId;

  TodoEntity({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  // Factory method to create an instance from a JSON object
  factory TodoEntity.fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  @override
  List<Object?> get props => [id, todo, completed, userId];

  @override
  bool? get stringify => true;
}
