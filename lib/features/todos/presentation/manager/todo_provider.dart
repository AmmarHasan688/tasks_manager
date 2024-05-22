import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tasks_manage/core/service_locator/get_it.dart';
import 'package:tasks_manage/core/utils/flush_bar.dart';
import 'package:tasks_manage/features/auth/presentation/pages/login.dart';
import 'package:tasks_manage/features/todos/domain/repositories/todo_repo.dart';
import 'package:tasks_manage/features/todos/domain/use_cases/delete_todo.dart';
import 'package:tasks_manage/features/todos/domain/use_cases/get_all.dart';
import 'package:tasks_manage/features/todos/domain/use_cases/update_todo.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/todo_model.dart';

class HomeProvider with ChangeNotifier {
  bool loading = false;
  bool gettingAnother = false;
  int currentPage = 1;
  final List<TodoModel> todos = [];
  final ScrollController scrollHomeController = ScrollController();
  final List<int> todoUnderUpdating = [];
  bool showingToast = false;

  HomeProvider() {
    addScrollListener();
  }

  void addScrollListener() {
    scrollHomeController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!loading && !gettingAnother && _isNearBottom()) {
      fetchMoreTodos();
    }
  }

  bool _isNearBottom() {
    return scrollHomeController.position.pixels >=
        (scrollHomeController.position.maxScrollExtent - 200);
  }

  Future<void> fetchMoreTodos() async {
    if (todos.isEmpty) {
      loading = true;
    } else {
      gettingAnother = true;
    }
    notifyListeners();

    final result =
        await GetAllTodos(todoRepo: getIt<TodoRepo>()).call(currentPage + 1);

    result.fold(
      (failure) => _handleFetchError(failure),
      (newTodos) => _handleFetchSuccess(newTodos),
    );
  }

  void _handleFetchError(Failure failure) {
    showToast(message: failure.errMessage);
    if (failure.errMessage.contains('token')) {
      const LoginScreen().launch(navigatorKey.currentContext!, isNewTask: true);
    } else {
      loading = false;
      gettingAnother = false;
      notifyListeners();
    }
  }


  void _handleFetchSuccess(List<TodoModel> newTodos) {
    if (!_areListsEqual(newTodos, todos)) {
      currentPage += 1;
      todos.addAll(newTodos);
    } else if (!showingToast) {
      showingToast = true;
      showToast(message: "You are offline").then((value) {
        showingToast = false;
      });
    }
    loading = false;
    gettingAnother = false;
    notifyListeners();
  }

  bool _areListsEqual(List<TodoModel> list1, List<TodoModel> list2) {
    return compareTodoListsIfTheyAreEquals(list1, list2);
  }

  Future<void> deleteTodoItem(int todoId) async {
    _startTodoUpdate(todoId);
    final result = await DeleteTodo(todoRepo: getIt<TodoRepo>()).call(todoId);

    result.fold(
      (failure) => showToast(message: failure.errMessage),
      (_) => todos.removeWhere((todo) => todo.id == todoId),
    );

    _endTodoUpdate(todoId);
  }

  Future<void> updateTodoItem(int todoId) async {
    _startTodoUpdate(todoId);
    final result = await UpdateTodo(todoRepo: getIt<TodoRepo>())
        .call(todoId: todoId, checked: true);

    result.fold(
      (failure) => showToast(message: failure.errMessage),
      (_) => todos.firstWhere((todo) => todo.id == todoId).completed = true,
    );

    _endTodoUpdate(todoId);
  }

  void _startTodoUpdate(int todoId) {
    todoUnderUpdating.add(todoId);
    notifyListeners();
  }

  void _endTodoUpdate(int todoId) {
    todoUnderUpdating.remove(todoId);
    notifyListeners();
  }
}
