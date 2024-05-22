import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tasks_manage/core/databases/cache/cache_helper.dart';
import 'package:tasks_manage/core/databases/cache/keys.dart';
import 'package:tasks_manage/core/service_locator/get_it.dart';
import 'package:tasks_manage/core/utils/bottom_sheets/confirmation_bottom_sheet.dart';
import 'package:tasks_manage/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:tasks_manage/features/auth/domain/repositories/auth_repo.dart';
import 'package:tasks_manage/features/auth/presentation/pages/login.dart';
import 'package:tasks_manage/features/todos/data/data_sources/local_repo.dart';
import 'package:tasks_manage/features/todos/data/models/todo_model.dart';
import 'package:tasks_manage/features/todos/presentation/manager/todo_provider.dart';
import 'package:tasks_manage/features/todos/presentation/widgets/todo_row.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _logout(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "TODO",
          ),
          leading: const SizedBox(),
          actions: [
            IconButton(
                onPressed: () async {
                  _logout(context);
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                )),
          ],
        ),
        body: ChangeNotifierProvider<HomeProvider>(
          create: (_) => HomeProvider(),
          child: Builder(builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Provider.of<HomeProvider>(context, listen: false).fetchMoreTodos();
              // Provider.of<HomeProvider>(context, listen: false)
              //     .addScrollListener();
            });
            return Consumer<HomeProvider>(
              builder: (context, prov, _) {
                if (prov.loading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else {
                  List<TodoModel> list = List.of(prov.todos);

                  bool gettingAnother = prov.gettingAnother;

                  return ListView.builder(
                      controller: prov.scrollHomeController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 40, top: 20),
                      itemCount: gettingAnother ? list.length + 1 : list.length,
                      itemBuilder: (context, i) {
                        if (i == list.length) {
                          return const SizedBox(
                              height: 70,
                              child:
                                  Center(child: CupertinoActivityIndicator()));
                        } else {
                          // return SizedBox(
                          //     height: 80,
                          //     child: Text(i.toString()));
                          return TodoRow(
                            todoModel: list[i],
                            onDelete: () {
                              prov.deleteTodoItem(list[i].id);
                            },
                            onChange: (v) {
                              if (v) {
                                prov.updateTodoItem(list[i].id);
                              }
                            },
                            updating:
                                prov.todoUnderUpdating.contains(list[i].id),
                          );
                        }
                      });
                }
              },
            );
          }),
        ),
      ),
    );
  }
}

void _logout(BuildContext context) {
  showConfirmationBottomSheet(context, onConfirm: () {
    getIt.get<CacheHelper>().clearValue(CacheKey.jwt);
    const LoginScreen().launch(context, isNewTask: true);
  }, type: ConfirmationType.logout);
}
