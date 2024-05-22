import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tasks_manage/core/connection/network_info.dart';
import 'package:tasks_manage/core/databases/cache/cache_helper.dart';
import 'package:tasks_manage/core/service_locator/get_it.dart';
import 'package:tasks_manage/features/auth/presentation/pages/login.dart';
import 'package:tasks_manage/features/todos/data/data_sources/local_repo.dart';
import 'package:tasks_manage/features/todos/data/data_sources/remote_repo.dart';
import 'package:tasks_manage/features/todos/data/repositories/todo_repo_impl.dart';
import 'package:tasks_manage/features/todos/domain/use_cases/delete_todo.dart';
import 'package:tasks_manage/features/todos/domain/use_cases/update_todo.dart';
import 'package:tasks_manage/features/todos/domain/use_cases/get_all.dart';
import 'package:tasks_manage/splash_screen.dart';

import 'core/databases/api/dio_consumer.dart';
import 'core/state_managment/providers.dart';
import 'core/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  initDependencies();
  // runApp(MultiProvider(providers: providers, child: const MyApp()));
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO App',
      navigatorKey: navigatorKey,
      theme: CustomTheme.lightTheme,
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
