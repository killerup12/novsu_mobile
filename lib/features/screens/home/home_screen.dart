import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novsu_mobile/features/screens/home/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<Widget> _pages;

  late int currentTabIndex;

  @override
  void initState() {
    super.initState();

    _pages = BlocProvider.of<HomeBloc>(context).getPages;

    currentTabIndex = 0;
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
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.wysiwyg),
              //   label: 'Journal'
              // ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.access_time,),
                label: 'Timetable'
              ),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.new_releases_outlined),
              //   label: 'Topical'
              // ),
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
    });
   }
}

