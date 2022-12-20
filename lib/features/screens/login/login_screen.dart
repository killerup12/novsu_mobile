import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novsu_mobile/features/screens/login/bloc/login_bloc.dart';
import 'package:novsu_mobile/features/theme/theme_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String logo = 'assets/images/logo.png';

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  late final LoginBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    loginTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => GestureDetector(
          onTap: () => hideKeyboard(),
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    width: 200,
                      child: Image.asset(logo)
                  ),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: loginTextController,
                      readOnly: checkIsWaitingResponse(state),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'login',  //TODO i18n
                    ),),
                  ),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordTextController,
                      readOnly: checkIsWaitingResponse(state),
                      decoration: const InputDecoration(
                        hintText: 'password', //TODO i18n
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  state is WaitingResponseLoginState
                  ? const CircularProgressIndicator()
                  : GestureDetector(
                    onTap: () => tryToLogIn(
                        loginTextController.text,
                        passwordTextController.text
                    ),
                    child: Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        color: ThemeHelper.getAppTheme().colorLoginButton,
                        borderRadius: const BorderRadius.all(Radius.circular(90)),
                        boxShadow: [
                          BoxShadow(
                            color: ThemeHelper.getAppTheme().colorShadowForLoginButton,
                            spreadRadius: 0.01,
                            blurRadius: 12,
                            offset: const Offset(0, 0),
                          )
                        ]
                      ),
                      child: Center(
                        child: Text('Log in', style: ThemeHelper.getAppTheme().textStyleForLoginButton),
                      ),
                    ),
                  )
                ],
              )
            ),
          ),
        )
    );
  }

  bool checkIsWaitingResponse(LoginState state) {
    return (state is WaitingResponseLoginState);
  }

  tryToLogIn(String uid, String password) {
    bloc.add(LoginToTheAccount(
        userName: loginTextController.text,
        password: passwordTextController.text
    ));
  }

  hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}



