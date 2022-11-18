import '../../domain/models/response_fields/responses_fields.dart';
import '../../domain/models/study_day.dart';

abstract class NovsuApi {
  Future<User> login();

  Future<List<StudyDay>> getTimetable();
}