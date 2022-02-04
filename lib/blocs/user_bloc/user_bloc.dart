import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:halosistest/models/login_model.dart';
import 'package:halosistest/models/users_model.dart';
import 'package:halosistest/services/users_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(InitialUserState());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoginEvent) {
      yield* _login(event.body);
    }
    if (event is GetUsersList) {
      yield* _getUsersList(event.page);
    }
  }
}

// Future<void> setPreferences(Login login) async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   if (login.code == 200) {
//     print("Masuk pref");
//     sharedPreferences.setInt("id_user", login.data!.user.idUser);
//     sharedPreferences.setInt("id_level", login.data!.user.idLevel);
//     sharedPreferences.setString("token_auth", login.data!.token);
//     // Get.offAndToNamed("/homePage");
//   }
// }

Stream<UserState> _login(body) async* {
  UsersService _apiProvider = UsersService();

  yield LoginWaiting();

  try {
    StatusLoginModel data = await _apiProvider.login(body);

    print(data.toString());

    if (data.status) {
      // print("Berhasil Login");
      // Get.offAndToNamed("/homePage");
    } else {
      print("Ditolak");
      Get.offNamed('/');
    }

    yield LoginSuccess(login: data);
  } catch (ex) {}
}

Stream<UserState> _getUsersList(page) async* {
  UsersService _apiProvider = UsersService();

  yield UsersListWaiting();

  try {
    UsersModel data = await _apiProvider.getListUsers(page);
    print("tunggu");
    yield UsersListSuccess(usersList: data);
  } catch (ex) {}
}
