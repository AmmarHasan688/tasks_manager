import 'package:dartz/dartz.dart';
import 'package:tasks_manage/core/databases/cache/cache_helper.dart';
import 'package:tasks_manage/core/databases/cache/keys.dart';
import 'package:tasks_manage/core/errors/exceptions.dart';
import 'package:tasks_manage/core/errors/failure.dart';
import 'package:tasks_manage/core/service_locator/get_it.dart';
import 'package:tasks_manage/features/todos/data/data_sources/local_repo.dart';
import 'package:tasks_manage/features/todos/data/data_sources/remote_repo.dart';
import 'package:tasks_manage/features/todos/data/models/todo_model.dart';
import 'package:tasks_manage/features/todos/domain/repositories/todo_repo.dart';

import '../../../../core/connection/network_info.dart';

class TodoRepoImpl extends TodoRepo {
  final NetworkInfo networkInfo;
  final TodoRemoteRepo remoteSource;
  final TodoLocalRepo localDataSource;

  TodoRepoImpl(
      {required this.remoteSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<TodoModel>>> getAll(int page) async {
    if ((await networkInfo.isConnected!)) {
      try {
        var jwt = await getIt.get<CacheHelper>().getData(key: CacheKey.jwt);
        var res = await remoteSource.getTodos(jwt, page);
        if (res.isNotEmpty) {
          localDataSource.cacheList(res);
          return Right(res);
        } else {
          return Left(Failure(errMessage: "List Limit Reached"));
        }
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Right(localDataSource.getStoredTodos());
    }
  }

  @override
  Future<Either<Failure, TodoModel>> editTask(
      {required int todoId, required bool checked}) async {
    if (await networkInfo.isConnected!) {
      try {
        var res = await remoteSource.editTodo(checked: checked, todoId: todoId);
        return Right(res);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "you are offline"));
    }
  }

  @override
  Future<Either<Failure, TodoModel>> deleteTodo(int todoId) async {
    if (await networkInfo.isConnected!) {
      var res = await remoteSource.deleteTodo(todoId: todoId);
      return Right(res);
    } else {
      return Left(Failure(errMessage: "you are offline"));
    }
  }
}
