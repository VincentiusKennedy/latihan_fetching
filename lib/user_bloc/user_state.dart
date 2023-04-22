part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserAuthenticatedState extends UserState {
  final User user;

  const UserAuthenticatedState({
    required this.user,
  });

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UserAuthenticatedState { user: $user }';
}

class UserErrorState extends UserState {
  final String errorMessage;

  const UserErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'UserErrorState { errorMessage: $errorMessage }';
}
