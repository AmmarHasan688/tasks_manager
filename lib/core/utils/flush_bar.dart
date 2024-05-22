import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart' hide ContextExtensions;
import 'package:tasks_manage/core/extentions/context_extentions.dart';

import '../../main.dart';

Future showToast(
    {required String message, IconData? icon}) async{
  var context= navigatorKey.currentContext;
  if(context == null)return;
  await Flushbar(
    message: message,
    duration: const Duration(seconds: 2),
    borderRadius: BorderRadius.circular(10),
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    icon: icon != null
        ? Icon(
            icon,
            size: 28.0,
            color: context.theme.primaryColor,
          )
        : null,
  ).show(context);
}
