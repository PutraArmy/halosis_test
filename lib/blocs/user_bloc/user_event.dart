import 'package:meta/meta.dart';

@immutable
abstract class UserEvent {}

class LoginEvent extends UserEvent {
  dynamic body;
  LoginEvent({required this.body});
}

class GetUsersList extends UserEvent {
  dynamic page;
  GetUsersList({required this.page});
}
