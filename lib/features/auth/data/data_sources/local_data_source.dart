import 'dart:convert';

import 'package:tasks_manage/core/databases/cache/keys.dart';

import '../../../../core/databases/cache/cache_helper.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

class AuthLocalDataSource {
  final CacheHelper cache;
  final String key = "CachedUser";

  AuthLocalDataSource({required this.cache});

  // cacheUser(UserModel? userToCache) {
  //   if (userToCache != null) {
  //     cache.saveData(
  //       key: key,
  //       value: json.encode(
  //         userToCache.toJson(),
  //       ),
  //     );
  //   } else {
  //     throw CacheExeption(errorMessage: "Cache Error");
  //   }
  // }
  cacheJwt(String jwt) async {
    cache.saveData(key: CacheKey.jwt, value: jwt);
  }

  Future<String?> getJwt() async {
    var res = await cache.getData(key: CacheKey.jwt);
    if (res is String) {
      return res;
    } else {
      return null;
    }
  }
}
