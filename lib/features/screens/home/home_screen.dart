import 'package:novsu_mobile/features/screens/home/bloc/home_bloc.dart';
import 'package:novsu_mobile/features/screens/home/bloc/home_events.dart';
import 'package:novsu_mobile/features/screens/home/bloc/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novsu_mobile/di/locator.dart';
import '../blocs.dart';
import '../journal/journal_screen.dart';
import '../services/services_screen.dart';
import '../timing/timing_screen.dart';
import '../topical/topical_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<Widget> _pages;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();

    _pages = [
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => Scaffold(
          body: IndexedStack(
            index: currentTabIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentTabIndex,
            onTap: onTap,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.wysiwyg),
                label: 'Journal'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.access_time,),
                label: 'Timing'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.new_releases_outlined),
                label: 'Topical'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.widgets),
                label: 'Services'
              )
            ],
          ),
        )
    );
  }
  
  onTap(int index) {
    setState(() {
      currentTabIndex = index;
      BlocProvider.of<HomeBloc>(context).add(ChangeSelectedScreenEvent(index: index));
    });
   }
}

