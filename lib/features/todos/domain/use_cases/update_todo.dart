import 'package:dartz/dartz.dart';
import 'package:tasks_manage/features/todos/domain/repositories/todo_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../../auth/domain/repositories/auth_repo.dart';
import '../../data/models/todo_model.dart';

class UpdateTodo {
  final TodoRepo todoRepo;

  UpdateTodo({required this.todoRepo});

  Future<Either<Failure, TodoModel>> call({required int todoId,required bool checked}) async {
    var res = await todoRepo.editTask(todoId: todoId,checked: checked);
    return res;
  }
}
