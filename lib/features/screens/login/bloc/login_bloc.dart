import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novsu_mobile/data/api/novsu_api.dart';
import 'package:novsu_mobile/data/server_interaction/server_interaction.dart';
import 'package:novsu_mobile/features/navigation/navigation_manager.dart';
import 'package:novsu_mobile/features/navigation/routes.dart';
import 'package:novsu_mobile/features/screens/login/bloc/login_event.dart';
import 'package:novsu_mobile/features/screens/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final NovsuApi novsuApi;
  final NavigationManager navigationManager;

  LoginBloc({
    required this.novsuApi,
    required this.navigationManager
  }) : super(InitLoginState()) {
    on<LoginToTheAccount>((event, emit) async => _mapLoginToTheAccount(event, emit));
  }

  _mapLoginToTheAccount(LoginToTheAccount event, Emitter emit) async {
    emit(WaitingResponseLoginState());

    try {
      final userInfo = (await novsuApi.login(Login(
          uid: event.userName,
          password: event.password
      ))).user;

      //TODO load data to the memory

      navigationManager.pushRouteWithReplacement(Routes.home);
    } catch (e) {
      //TODO show a message 'login or password is wrong'
      print(e); //TODO remove
      emit(InitLoginState());
      //TODO add exceptions
    }
  }
}