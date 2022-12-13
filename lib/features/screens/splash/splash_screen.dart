import 'package:novsu_mobile/features/screens/splash/bloc/splash_bloc.dart';
import 'package:novsu_mobile/features/screens/splash/bloc/splash_events.dart';
import 'package:novsu_mobile/features/screens/splash/bloc/splash_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
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
                      const ColoredBox(
                        color: Colors.blue,
                        child: SizedBox.square(dimension: 50,), //TODO add normal image!!
                      ),
                      getSteps() //TODO remove
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

    return Text(answer, style: TextStyle(
      color: Colors.black,
      fontSize: 10
    ),);
  }
}