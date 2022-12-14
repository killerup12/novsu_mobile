import 'package:novsu_mobile/domain/models/models.dart';
import 'package:novsu_mobile/features/screens/blocs.dart';
import 'package:novsu_mobile/features/screens/timetable/decorations/study_day_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimingScreen extends StatefulWidget {
  const TimingScreen({Key? key}) : super(key: key);

  @override
  State<TimingScreen> createState() => _TimingScreenState();
}

class _TimingScreenState extends State<TimingScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<TimingBloc>(context).add(GetSchoolDaysEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimingBloc, TimingState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Timing'),  //TODO i18n
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: showTimingInformation(state)
          ),
        )
      ),
    );
  }

  Widget showTimingInformation(TimingState state) {
    if (state is LoadedSchoolDaysState) {
      return convertTimetableToWidget(state.timetable);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget convertTimetableToWidget(Timetable timetable) {
    List<Widget> lessonsWidget = [];

    for (StudyDay element in timetable.studyDays) {
      lessonsWidget.add(SchoolDayWidget(schoolDay: element));

      if (element != timetable.studyDays.last) {
        lessonsWidget.add(const SizedBox(height: 20));
      }
    }

    return Column(children: lessonsWidget);
  }
}
