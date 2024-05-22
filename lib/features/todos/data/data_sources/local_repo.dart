import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tasks_manage/core/databases/cache/cache_helper.dart';
import 'package:tasks_manage/core/databases/cache/keys.dart';
import 'package:tasks_manage/core/errors/failure.dart';
import 'package:tasks_manage/features/todos/data/models/todo_model.dart';

class TodoLocalRepo {
  final CacheHelper cacheHelper;

  TodoLocalRepo({required this.cacheHelper});

  void cacheList(List<TodoModel> res) {
    var storedList = getStoredTodos();
    List<TodoModel> filteredList = List.of(storedList);
    for (var resItem in res) {
      int i = storedList.indexWhere((element) => resItem.id == element.id);
      if (i == -1) {
        filteredList.add(resItem);
      }
    }
    List<String> encoded =
        filteredList.map((e) => jsonEncode(e.toJson())).toList();
    cacheHelper.saveData(key: CacheKey.todos, value: jsonEncode(encoded));
  }

  List<TodoModel> getStoredTodos() {
    var res = cacheHelper.getData(key: CacheKey.todos);
    List<TodoModel> list = <TodoModel>[];
    if (res != null) {
      List<String> strList =
          (jsonDecode(res) as List).map((e) => e.toString()).toList();
      for (var element in strList) {
        TodoModel todoModel = TodoModel.fromJson(jsonDecode(element));
        list.add(todoModel);
      }
    }
    return list;
  }
}
