import 'package:novsu_mobile/domain/models/journal.dart';
import 'package:novsu_mobile/features/decorations/subject_widget.dart';
import 'package:novsu_mobile/features/screens/journal/bloc/journal_bloc.dart';
import 'package:novsu_mobile/features/screens/journal/bloc/journal_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/journal_events.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<JournalBloc>(context).add(LoadJournalEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JournalBloc, JournalState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Journal'), //TODO i18n
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: (state is LoadedSubjectsState)
                ? Column(children: convertSubjectsToWidgets(state.journalItems))
                : const Center(child: CircularProgressIndicator()),
          ),
        )
      ),
    );
  }

  List<Widget> convertSubjectsToWidgets(List<Journal> subjects) {
    List<Widget> subjectWidgets = [];

    for (Journal element in subjects) {
      subjectWidgets.add(SubjectWidget(
        journalItem: element,
        onTap: () {

        }));

      if (element != subjects.last) {
        subjectWidgets.add(const SizedBox(height: 20));
      }
    }

    return subjectWidgets;
  }
}