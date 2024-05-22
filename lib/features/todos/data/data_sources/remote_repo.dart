import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/errors/failure.dart';
import '../models/todo_model.dart';

class TodoRemoteRepo {
  final ApiConsumer api;

  TodoRemoteRepo({required this.api});

  Future<List<TodoModel>> getTodos(String jwt, int page) async {
    int limit = 10;
    String skipString = '';
    if (page > 1) {
      skipString += "&";
      skipString += "skip=${(page - 1) * 10}";
    }
    var res = await api.get("${EndPoints.allTodos}?limit=$limit$skipString",
        jwt: jwt);
    var list = res['todos'];
    list as List;
    List<TodoModel> todoList = [];
    for (var element in list) {
      todoList.add(TodoModel.fromJson(element));
    }
    return todoList;
  }

  Future<TodoModel> editTodo(
      {required int todoId, required bool checked}) async {
    var res = await api.patch('${EndPoints.editTodo}/$todoId',
        data: {ApiKey.completed: checked});
    return TodoModel.fromJson(res);
  }

  Future<TodoModel> deleteTodo({required int todoId}) async {
    var res = await api.delete(
      '${EndPoints.editTodo}/$todoId',
    );
    return TodoModel.fromJson(res);
  }
}
