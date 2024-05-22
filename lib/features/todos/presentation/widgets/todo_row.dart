import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tasks_manage/core/utils/bottom_sheets/confirmation_bottom_sheet.dart';
import 'package:tasks_manage/features/todos/data/models/todo_model.dart';

class TodoRow extends StatelessWidget {
  final TodoModel todoModel;
  final bool updating;
  final Function(bool) onChange;
  final Function onDelete;

  const TodoRow(
      {super.key,
      required this.todoModel,
      required this.updating,
      required this.onChange,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                todoModel.todo,
                style: TextStyle(
                  fontSize: 18.0,
                  decoration:
                      todoModel.completed ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Visibility(
                visible: !updating,
                replacement: const CupertinoActivityIndicator(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      onPressed: () {
                        showConfirmationBottomSheet(context, onConfirm: () {
                          pop();
                          onDelete.call();
                        }, type: ConfirmationType.delete);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                    ),
                    Checkbox(
                      value: todoModel.completed,
                      onChanged: (v) => onChange.call(v ?? false),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
