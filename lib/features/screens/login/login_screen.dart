import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
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

  bool isSomethingWrong = false;
  bool obscureText = true;

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
        if (state is ErrorLoginScreenState) {
          isSomethingWrong = true;
          showTopSnackBar(
            Overlay.of(context)!,
            CustomSnackBar.error(
              message: state.message,
            ),
            animationDuration: const Duration(seconds: 2)
          );
        }
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
                          isSomethingWrong = false;
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
                    child: Stack(
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              isSomethingWrong = false;
                            });
                          },
                          obscureText: obscureText,
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              IconButton(
                                icon: _getEyeIcon(obscureText),
                                color: ThemeHelper.getAppTheme().iconButtonColor,
                                iconSize: 20,
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
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
                    isSomethingWrong: isSomethingWrong,
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

  _getEyeIcon(bool obscureText) => (obscureText)
      ? const Icon(Icons.visibility_outlined)
      : const Icon(Icons.visibility_off_outlined);

  tryToLogIn(String uid, String password) {
    hideKeyboard();
    isSomethingWrong = false;
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
  final Color _errorColor = ThemeHelper.getAppTheme().errorActionButton;

  final Color _enableShadow = ThemeHelper.getAppTheme().colorShadowForLoginButton;
  final Color _errorShadow = ThemeHelper.getAppTheme().colorErrorShadowForLoginButton;

  final VoidCallback onTap;
  final bool isEnable;
  bool isSomethingWrong;

  _LoginButton({
    Key? key,
    required this.onTap,
    required this.isEnable,
    this.isSomethingWrong = false
  }) : super(key: key);

  @override
  State<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton> with SingleTickerProviderStateMixin {
  late final Animation<Color?> animationCurrent;
  late final Animation<Color?> animationError;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 70), vsync: this);
    animationError = ColorTween(begin: widget._disableColor, end: widget._errorColor).animate(controller);
    animationCurrent = ColorTween(begin: widget._disableColor, end: widget._enableColor).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.isSomethingWrong ? animationError : animationCurrent,
      builder: (context, child) => InkWell(
        borderRadius: BorderRadius.circular(90),
        onTap: animationHelper(),
        child: Container(
          height: 70,
          width: 200,
          decoration: BoxDecoration(
              color: widget.isSomethingWrong ? animationError.value : animationCurrent.value,
              borderRadius: const BorderRadius.all(Radius.circular(90)),
              boxShadow: [
                BoxShadow(
                  color: widget.isSomethingWrong ? widget._errorShadow : widget._enableShadow,
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
