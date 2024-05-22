import 'package:dartz/dartz.dart';
import 'package:tasks_manage/core/errors/failure.dart';
import 'package:tasks_manage/features/todos/data/models/todo_model.dart';

abstract class TodoRepo {
  Future<Either<Failure, List<TodoModel>>> getAll(int page);
  Future<Either<Failure, TodoModel>> editTask({required int todoId,required bool checked});

  Future<Either<Failure, TodoModel>> deleteTodo(int todoId);

}
