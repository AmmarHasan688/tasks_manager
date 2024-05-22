import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tasks_manage/core/databases/cache/cache_helper.dart';
import 'package:tasks_manage/core/databases/cache/keys.dart';
import 'package:tasks_manage/core/service_locator/get_it.dart';
import 'package:tasks_manage/features/auth/presentation/pages/login.dart';
import 'package:tasks_manage/features/todos/presentation/manager/todo_provider.dart';
import 'package:tasks_manage/features/todos/presentation/pages/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1, milliseconds: 500))
          .then((value) {
        var loggedId =
            getIt.get<CacheHelper>().getData(key: CacheKey.jwt) != null;
        if (loggedId) {
          const HomePage().launch(context);
        } else {
          const LoginScreen().launch(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.task_alt,
        size: context.width() * 0.3,
        color: context.theme.primaryColor,
      ),
    );
  }
}
