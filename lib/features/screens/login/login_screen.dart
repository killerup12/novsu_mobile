import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novsu_mobile/features/screens/login/bloc/login_bloc.dart';
import 'package:novsu_mobile/features/screens/login/bloc/login_event.dart';
import 'package:novsu_mobile/features/screens/login/bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    loginTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: loginTextController,
                    readOnly: checkIsWaitingResponse(state),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'login',
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordTextController,
                    readOnly: checkIsWaitingResponse(state),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'password'
                    ),
                  ),
                ),
                state is WaitingResponseLoginState
                ? const CircularProgressIndicator()
                : GestureDetector(
                  onTap: () => BlocProvider.of<LoginBloc>(context).add(LoginToTheAccount(
                      userName: loginTextController.text,
                      password: passwordTextController.text
                  )),
                  child: Container(
                    height: 70,
                    width: 300,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: const Text('Log in',
                      style: TextStyle(fontSize: 15),), //TODO add to theme
                  ),
                )
              ],
            )
          ),
        )
    );
  }

  bool checkIsWaitingResponse(LoginState state) {
    return (state is WaitingResponseLoginState);
  }
}



