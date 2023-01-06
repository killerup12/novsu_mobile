import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novsu_mobile/features/navigation/hero_tags.dart';
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
  final validationKey = GlobalKey<FormState>();

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
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {

      },
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
                      child: Hero(
                          tag: HeroTags.splashToLogin,
                          child: Image.asset(logo)
                      )
                  ),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {

                        });
                      },
                      autocorrect: false,
                      controller: loginTextController,
                      readOnly: checkIsWaitingResponse(state),
                      decoration: const InputDecoration(
                        hintText: 'login',  //TODO i18n
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {

                        });
                      },
                      autocorrect: false,
                      controller: passwordTextController,
                      readOnly: checkIsWaitingResponse(state),
                      decoration: const InputDecoration(
                        hintText: 'password', //TODO i18n
                      ),
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () => tryToLogIn(
                          loginTextController.text,
                          passwordTextController.text
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (state is WaitingResponseLoginState)
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 17),
                        child: CircularProgressIndicator()
                  )
                  else  _LoginButton(
                    onTap: () => tryToLogIn(
                      loginTextController.text,
                      passwordTextController.text
                    ),
                    isEnable: checkLoginButtonIsReady(),
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

  bool checkLoginButtonIsReady() {
    if (loginTextController.text.isNotEmpty & passwordTextController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  tryToLogIn(String uid, String password) {
    hideKeyboard();
    bloc.add(LoginToTheAccount(
        userName: loginTextController.text,
        password: passwordTextController.text
    ));
  }

  hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isEnable;

  const _LoginButton({
    Key? key,
    required this.onTap,
    required this.isEnable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnable ? onTap : () {},
      child: Container(
        height: 70,
        width: 200,
        decoration: BoxDecoration(
            color: _getButtonStateColor(isEnable),
            borderRadius: const BorderRadius.all(Radius.circular(90)),
            boxShadow: [
              isEnable == true ? BoxShadow(
                color: ThemeHelper.getAppTheme().colorShadowForLoginButton,
                spreadRadius: 0.01,
                blurRadius: 12,
                offset: const Offset(0, 0),
              ) : const BoxShadow()
            ]
        ),
        child: Center(
          child: Text('Log in', style: ThemeHelper.getAppTheme().textStyleForLoginButton),
        ),
      ),
    );
  }

  Color _getButtonStateColor(bool isEnable) {
    if (isEnable) {
      return ThemeHelper.getAppTheme().enableActionButton;
    } else {
      return ThemeHelper.getAppTheme().disableActionButton;
    }
  }

  Color? _getShadowStateColor(bool isEnable) {
    if (isEnable) {
      return ThemeHelper.getAppTheme().enableActionButton;
    } else {
      return null;
    }
  }
}
