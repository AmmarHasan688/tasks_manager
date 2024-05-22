import 'package:dartz/dartz.dart';
import 'package:tasks_manage/features/todos/domain/repositories/todo_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../../auth/domain/repositories/auth_repo.dart';
import '../../data/models/todo_model.dart';

class GetAllTodos {
  final TodoRepo todoRepo;

  GetAllTodos({required this.todoRepo});

  Future<Either<Failure, List<TodoModel>>> call(int page) async {
    var res = await todoRepo.getAll(page);
    return res;
  }
}
