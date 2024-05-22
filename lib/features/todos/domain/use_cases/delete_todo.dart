import 'package:dartz/dartz.dart';
import 'package:tasks_manage/features/todos/domain/repositories/todo_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../../auth/domain/repositories/auth_repo.dart';
import '../../data/models/todo_model.dart';

class DeleteTodo {
  final TodoRepo todoRepo;

  DeleteTodo({required this.todoRepo});

  Future<Either<Failure, TodoModel>> call(int todoId) async {
    var res = await todoRepo.deleteTodo(todoId);
    return res;
  }
}
