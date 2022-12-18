import 'package:hive/hive.dart';

part '../hive_adapters/lesson_types.g.dart';

@HiveType(typeId: 4)
enum LessonTypes {
  @HiveField(0)
  lecture,
  @HiveField(1)
  practice,
  @HiveField(2)
  unknown
}