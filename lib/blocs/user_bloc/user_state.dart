import 'package:halosistest/models/login_model.dart';
import 'package:halosistest/models/users_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserState {}

class InitialUserState extends UserState {}


// login
class LoginError extends UserState {
  final String? errorMessage;

  LoginError({
    this.errorMessage,
  });
}

class LoginWaiting extends UserState {}

class LoginSuccess extends UserState {
  final StatusLoginModel login;
  LoginSuccess({required this.login});
}

// user dashboard
class UsersListError extends UserState {
  final String? errorMessage;

  UsersListError({
    this.errorMessage,
  });
}

class UsersListWaiting extends UserState {}

class UsersListSuccess extends UserState {
  final UsersModel usersList;
  UsersListSuccess({required this.usersList});
}
