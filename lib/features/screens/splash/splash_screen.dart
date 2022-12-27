import 'package:novsu_mobile/features/screens/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  static const String logo = 'assets/images/logo.png';

  late final AnimationController controller;
  late final Animation<double> sizeAnimation;

  final List<String> steps = []; //TODO remove

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..addListener(() => setState(() {}))
      ..forward();
    sizeAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutQuad));
    Future.delayed(const Duration(seconds: 2),() {
      BlocProvider.of<SplashBloc>(context).add(GoToTheNextScreenEvent());
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext  context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        return BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is StepEvent) {
              setState(() {
                steps.add(state.step);
              });
            }
          },
          child: Scaffold(
            body: Center(
              child: Transform.scale(
                  scale: sizeAnimation.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(logo,
                        width: 133,
                      ),
                    ],
                  )
              ))
          ),
        );
      }
    );
  }

  Text getSteps() { //TODO remove
    String answer = '';

    for (String element in steps) {
      answer += element;
      answer += '\n';
    }

    return Text(answer, style: const TextStyle(
      color: Colors.black,
      fontSize: 10
    ),);
  }
}