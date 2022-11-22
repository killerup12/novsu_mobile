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

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..addListener(() => setState(() {}))
      ..forward();
    sizeAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutQuad));
    BlocProvider.of<SplashBloc>(context).add(GoToTheNextScreenEvent());
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
        return Scaffold(
        body: Center(
          child: Transform.scale(
              scale: sizeAnimation.value,
              child: const ColoredBox(
                color: Colors.blue,
                child: SizedBox.square(dimension: 50,), //TODO add normal image!!
              )
          )
        ),
      );}
    );
  }

  startTransitionAnimation() {

  }
}