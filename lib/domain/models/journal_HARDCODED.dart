import 'package:novsu_mobile/domain/models/journal_item.dart';

class Journal {
  static final List<JournalItem> journalItems = [
    const JournalItem(subject: 'Math', grade: 4),
    const JournalItem(subject: 'Biology', grade: 3.2),
    const JournalItem(subject: 'Geography', grade: 2.6),
    const JournalItem(subject: 'Information Technologies', grade: 5),
    const JournalItem(subject: 'Literature', grade: 4.1),
    const JournalItem(subject: 'English', grade: 4.3),
    const JournalItem(subject: 'Russian', grade: 5)
  ];
}