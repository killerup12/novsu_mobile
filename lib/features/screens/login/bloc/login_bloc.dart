import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novsu_mobile/data/api/novsu_api.dart';
import 'package:novsu_mobile/data/server_interaction/server_interaction.dart';
import 'package:novsu_mobile/domain/exceptions/exceptions.dart';
import 'package:novsu_mobile/domain/models/user.dart';
import 'package:novsu_mobile/domain/utils/memory_access_provider.dart';
import 'package:novsu_mobile/features/navigation/navigation_manager.dart';
import 'package:novsu_mobile/features/navigation/routes.dart';
import 'package:novsu_mobile/features/screens/login/bloc/login_event.dart';
import 'package:novsu_mobile/features/screens/login/bloc/login_state.dart';

export 'login_event.dart';
export 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final NovsuApi novsuApi;
  final NavigationManager navigationManager;
  final MemoryAccessProvider memoryAccessProvider;

  LoginBloc({
    required this.novsuApi,
    required this.navigationManager,
    required this.memoryAccessProvider
  }) : super(InitLoginState()) {
    on<LoginToTheAccount>((event, emit) async => _mapLoginToTheAccount(event, emit));
  }

  _mapLoginToTheAccount(LoginToTheAccount event, Emitter emit) async {
    emit(WaitingResponseLoginState());

    try {
      final User userInfo = (await novsuApi.login(Login(
          uid: event.userName.trim(),
          password: event.password.trim()
      ))).user;

      memoryAccessProvider.setUser(userInfo);

      memoryAccessProvider.setTimetable(await novsuApi.getTimetable(
          memoryAccessProvider.getUser().uid)); //TODO rework this shit

      navigationManager.pushRouteWithReplacement(Routes.home);
    } on UnauthorizedException catch (e) {
      emit(WrongLoginOrPasswordState(
        message: 'Wrong login or password!' //TODO i18n
      ));
    } on BadRequestException catch(e) {
      emit(WrongLoginOrPasswordState(
        message: 'Wrong login or password!' //TODO i18n
      ));
    } on NoInternetConnectionException catch(e) {
      emit(WrongLoginOrPasswordState(
          message: 'No internet connection! Try to log in later!' //TODO i18n
      ));
    }
  }
}