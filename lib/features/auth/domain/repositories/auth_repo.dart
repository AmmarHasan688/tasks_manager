import "package:dartz/dartz.dart";
import "package:tasks_manage/core/errors/failure.dart";
import "package:tasks_manage/core/params/params.dart";
import "package:tasks_manage/features/auth/domain/entities/user_entity.dart";

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> login({required LoginParams loginParams});


}
