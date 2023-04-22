import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latihan_post/API/api_service.dart';
import 'package:latihan_post/model/me_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;
  final SharedPreferences sharedPreferences;

  UserBloc({
    required this.apiService,
    required this.sharedPreferences,
  }) : super(UserInitialState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserCheckLoginEvent) {
      final token = sharedPreferences.getString("token");
      final userJson = sharedPreferences.getString("user");
      if (token != null && userJson != null) {
        final user = User.fromJson(json.decode(userJson));
        yield UserAuthenticatedState(user: user);
      } else {
        yield UserInitialState();
      }
    }
  }
}
