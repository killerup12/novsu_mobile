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

class _LoginButton extends StatefulWidget {
  final Color _enableColor = ThemeHelper.getAppTheme().enableActionButton;
  final Color _disableColor = ThemeHelper.getAppTheme().disableActionButton;

  final VoidCallback onTap;
  final bool isEnable;

  _LoginButton({
    Key? key,
    required this.onTap,
    required this.isEnable
  }) : super(key: key);

  @override
  State<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton> with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 70), vsync: this);
    animation = ColorTween(begin: widget._disableColor, end: widget._enableColor).animate(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => InkWell(
        onTap: animationHelper(),
        child: Container(
          height: 70,
          width: 200,
          decoration: BoxDecoration(
              color: animation.value,
              borderRadius: const BorderRadius.all(Radius.circular(90)),
              boxShadow: [
                BoxShadow(
                  color: ThemeHelper.getAppTheme().colorShadowForLoginButton,
                  spreadRadius: 0.01,
                  blurRadius: 12 * controller.value,
                  offset: const Offset(0, 0),
                )
              ]
          ),
          child: Center(
            child: Text('Log in', style: ThemeHelper.getAppTheme().textStyleForLoginButton),
          ),
        ),
      ),
    );
  }

  VoidCallback? animationHelper() {
    if (widget.isEnable) {
      controller.forward();
      return widget.onTap;
    } else {
      controller.reverse();
      return null;
    }
  }
}
