import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:tasks_manage/features/auth/presentation/manager/auth_proivder.dart';
import 'package:tasks_manage/features/todos/presentation/manager/todo_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => HomeProvider()),
  ChangeNotifierProvider(create: (_) => AuthProvider()),
];
