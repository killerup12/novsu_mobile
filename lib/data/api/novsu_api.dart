import 'package:novsu_mobile/domain/models/timeable_item.dart';

import 'package:novsu_mobile/domain/models/response_fields/responses_fields.dart';

abstract class NovsuApi {
  Future<User> login();

  Future<Timetable> getTimetable();
}