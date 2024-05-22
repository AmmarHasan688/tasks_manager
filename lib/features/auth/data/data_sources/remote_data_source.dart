import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:tasks_manage/core/errors/error_model.dart';
import 'package:tasks_manage/core/params/params.dart';

import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final ApiConsumer api;

  AuthRemoteDataSource({required this.api});

  Future<UserModel> login(LoginParams params) async {
    // throw BadResponseException(ErrorModel(status: 1, errorMessage: "errorMessage"));
    final response = await api.post(
      EndPoints.login,
      data: {
        ApiKey.username: params.username,
        ApiKey.password: params.password,
      },
    );
    return UserModel.fromJson(response.data);
  }

  Future<String> refreshAuthToken(String jwt) async {
    final response = await api.post(EndPoints.refreshToken, jwt: jwt);
    return response.data['token'];
  }
}
