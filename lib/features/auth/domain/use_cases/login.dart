import 'package:tasks_manage/core/params/params.dart';
import 'package:tasks_manage/features/auth/domain/entities/user_entity.dart';
import 'package:tasks_manage/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

class Login {
  final AuthRepo authRepo;

  Login({required this.authRepo});

  Future<Either<Failure, UserEntity>> call({required LoginParams params}) {
    return authRepo.login(loginParams: params);
  }
}
