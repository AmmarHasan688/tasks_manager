import 'package:equatable/equatable.dart';
import 'package:tasks_manage/features/todos/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel(
      {required super.id,
      required super.todo,
      required super.completed,
      required super.userId});

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  @override
  bool? get stringify => true;
}

bool compareTodoListsIfTheyAreEquals(List<TodoModel> a, List<TodoModel> b) {
  if (a.length != b.length) {
    return false;
  }
  if (identical(a, b)) {
    return true;
  }
  for (int index = 0; index < a.length; index += 1) {
    if (a[index] != b[index]) {
      return false;
    }
  }
  return true;
}
