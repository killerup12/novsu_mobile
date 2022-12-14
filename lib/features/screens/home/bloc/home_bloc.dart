import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novsu_mobile/di/locator.dart';
import 'package:novsu_mobile/features/screens/screens.dart';
import 'package:novsu_mobile/features/screens/blocs.dart';

export 'home_events.dart';
export 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<Widget> _pages = [
    // BlocProvider(
    //     create: (context) => locator<JournalBloc>(),
    //   child: const JournalScreen(),
    // ),
    BlocProvider(
      create: (context) => locator<TimingBloc>(),
      child: const TimingScreen(),
    ),
    // BlocProvider(
    //   create: (context) => locator<TopicalBloc>(),
    //   child: const TopicalScreen(),
    // ),
    BlocProvider(
        create: (context) => locator<ServicesBloc>(),
        child: const ServicesScreen()
    )
  ];

  HomeBloc() : super(InitHomeState());

  List<Widget> get getPages => _pages;
}