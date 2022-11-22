import 'package:novsu_mobile/data/server_interaction/server_interaction.dart';
import 'package:novsu_mobile/domain/models/timeable_item.dart';

abstract class NovsuApi {
  Future<SignedIn> login();

  Future<Timetable> getTimetable();
}