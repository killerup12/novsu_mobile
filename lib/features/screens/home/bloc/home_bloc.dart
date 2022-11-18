import 'package:novsu_mobile/di/locator.dart';
import 'package:novsu_mobile/features/screens/home/bloc/home_events.dart';
import 'package:novsu_mobile/features/screens/journal/journal_screen.dart';
import 'package:novsu_mobile/features/screens/services/services_screen.dart';
import 'package:novsu_mobile/features/screens/timing/timing_screen.dart';
import 'package:novsu_mobile/features/screens/topical/topical_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs.dart';
import 'home_states.dart';

List<Widget> _pages = [
  BlocProvider(
      create: (context) => locator<JournalBloc>(),
    child: const JournalScreen(),
  ),
  BlocProvider(
    create: (context) => locator<TimingBloc>(),
    child: const TimingScreen(),
  ),
  BlocProvider(
    create: (context) => locator<TopicalBloc>(),
    child: const TopicalScreen(),
  ),
  BlocProvider(
    create: (context) => locator<ServicesBloc>(),
    child: const ServicesScreen()
  )
];

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(InitHomeState(page: _pages[0])) {
    on<ChangeSelectedScreenEvent>((event, emit) => emit(_selectPage(event.index)));
  }

  SelectedPageState _selectPage(int index) {
    return SelectedPageState(page: _pages[index]);
  }
}