import 'package:novsu_mobile/data/server_interaction/server_interaction.dart';
import 'package:novsu_mobile/domain/models/timetable.dart';

abstract class NovsuApi {
  Future<SignedIn> login(Login login);

  Future<Timetable> getTimetable(String studentId);

  Future getMainProfilePage();
}