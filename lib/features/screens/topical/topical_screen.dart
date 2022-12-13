import 'package:novsu_mobile/features/screens/blocs.dart';
import 'package:novsu_mobile/features/screens/topical/bloc/topical_events.dart';
import 'package:novsu_mobile/features/screens/topical/bloc/topical_states.dart';
import 'package:novsu_mobile/features/screens/topical/decorations/news_widget.dart';
import 'package:novsu_mobile/features/screens/topical/decorations/school_day_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/news_item.dart';

class TopicalScreen extends StatefulWidget {
  const TopicalScreen({Key? key}) : super(key: key);

  @override
  State<TopicalScreen> createState() => _TopicalScreenState();
}

class _TopicalScreenState extends State<TopicalScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopicalBloc>(context).add(LoadDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicalBloc, TopicalState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Topical'), //TODO i18n
          leading: GestureDetector(
            onTap: () => BlocProvider.of<TopicalBloc>(context).add(LogOutEvent()),
            child: const Icon(
              Icons.sensor_door_outlined,
              color: Colors.red,
            ),
          )
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildInformationPartUsingState(state),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInformationPartUsingState(TopicalState state) {
    if (state is DataIsReadyForUsingState) {
      return [
        ...buildTodayTiming(state),
        ...buildNews(state)
      ];
    } else {
      return const [SizedBox()];
    }
  }

  List<Widget> buildTodayTiming(DataIsReadyForUsingState state) {
    return [
      SchoolDayWidget(schoolDay: state.schoolDay),
      const SizedBox(height: 20)
    ];
  }

  List<Widget> buildNews(DataIsReadyForUsingState state) {
    final List<Widget> allNews = [];

    for (News news in state.news) {
      allNews.add(NewsWidget(image: news.image));

      if (news != state.news.last) {
        allNews.add(NewsWidget(image: news.image));
      }
    }

    return allNews;
  }
}
