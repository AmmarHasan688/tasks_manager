import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tasks_manage/core/params/params.dart';
import 'package:tasks_manage/core/service_locator/get_it.dart';
import 'package:tasks_manage/core/utils/flush_bar.dart';
import 'package:tasks_manage/features/auth/domain/use_cases/login.dart';
import 'package:tasks_manage/features/todos/presentation/pages/home.dart';

import '../../domain/repositories/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  bool loading = false;

  void login(LoginParams params) async {
    loading = true;
    notifyListeners();
    var res = await Login(authRepo: getIt.get<AuthRepo>()).call(params: params);
    loading = false;
    notifyListeners();
    res.fold((l) {
      showToast(message: l.errMessage);
    }, (r) {
      const HomePage().launch(navigatorKey.currentContext!,
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Slide);
    });
  }
}
