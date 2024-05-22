import 'package:dartz/dartz.dart';
import 'package:tasks_manage/core/connection/network_info.dart';
import 'package:tasks_manage/core/errors/error_model.dart';
import 'package:tasks_manage/core/errors/exceptions.dart';
import 'package:tasks_manage/core/errors/failure.dart';
import 'package:tasks_manage/core/params/params.dart';
import 'package:tasks_manage/features/auth/data/data_sources/local_data_source.dart';
import 'package:tasks_manage/features/auth/domain/entities/user_entity.dart';
import 'package:tasks_manage/features/auth/domain/repositories/auth_repo.dart';

import '../../../../core/databases/cache/cache_helper.dart';
import '../../../../core/databases/cache/keys.dart';
import '../../../../core/service_locator/get_it.dart';
import '../data_sources/remote_data_source.dart';

class AuthRepoImpl extends AuthRepo {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepoImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, UserEntity>> login(
      {required LoginParams loginParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteUser = await remoteDataSource.login(loginParams);

        localDataSource.cacheJwt(remoteUser.token);

        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "No Internet"));
    }
  }



}
