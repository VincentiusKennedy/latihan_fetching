part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserCheckLoginEvent extends UserEvent {}

class UserLoginEvent extends UserEvent {
  final String email;
  final String password;

  const UserLoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'UserLoginEvent { email: $email, password: $password }';
}

class UserLogoutEvent extends UserEvent {}
