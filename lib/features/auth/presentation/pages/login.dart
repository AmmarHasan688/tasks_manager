import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tasks_manage/core/params/params.dart';
import 'package:tasks_manage/features/auth/presentation/manager/auth_proivder.dart';
import 'package:tasks_manage/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:tasks_manage/generated/assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController userNameCont;
  late TextEditingController passwordCont;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    userNameCont = TextEditingController();
    passwordCont = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameCont.dispose();
    passwordCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const SizedBox(),
          title: const Text(
            'Login',
            style: TextStyle(),
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              Assets.assetsBG,
              width: context.width(),
              height: context.height(),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      flex: 20,
                      child: Icon(
                        Icons.task_alt,
                        size: context.width() * 0.3,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 40,
                      child: Column(
                        children: [
                          AuthTextField(
                            validator: (value) {
                              value as String?;
                              if (value == null ||
                                  value.removeAllWhiteSpace().isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            controller: userNameCont,
                            hint: "Username",
                            textFieldType: TextFieldType.EMAIL,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AuthTextField(
                              controller: passwordCont,
                              validator: (str) {
                                str as String?;
                                if (str.removeAllWhiteSpace().isEmpty) {
                                  return "Please fill your password";
                                }
                                return null;
                              },
                              textFieldType: TextFieldType.PASSWORD,
                              hint: "Password"),
                          const SizedBox(height: 30),
                          ChangeNotifierProvider<AuthProvider>(
                            create: (_) => AuthProvider(),
                            child: Consumer<AuthProvider>(
                                builder: (context, prov, _) {
                              return prov.loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : SizedBox(
                                      width: context.width() * 0.6,
                                      height: 45,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (!formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          prov.login(LoginParams(
                                              username: "kminchelle",
                                              password: '0lelplR'));
                                        },
                                        child: const Text('Login'),
                                      ),
                                    );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
