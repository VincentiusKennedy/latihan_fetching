import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:latihan_post/API/api_service.dart';
import 'package:latihan_post/model/me_model.dart';
import 'package:latihan_post/screen/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;
  final SharedPreferences sharedPreferences;
  final BuildContext context;

  LoginBloc({
    required this.apiService,
    required this.sharedPreferences,
    required this.context,
  }) : super(LoginInitialState()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final token = await apiService.login(event.email, event.password);
        sharedPreferences.setString("token", token);
        final user = await apiService.getUserData(token);
        sharedPreferences.setString("user", json.encode(user.toJson()));
        emit(LoginSuccessState(user: user));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      } catch (e) {
        emit(LoginFailureState(errorMessage: e.toString()));
      }
    });
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoadingState();
      try {
        final token = await apiService.login(event.email, event.password);
        final user = await apiService.getUserData(token);
        sharedPreferences.setString("token", token);
        sharedPreferences.setString("user", json.encode(user.toJson()));
        yield LoginSuccessState(user: user);
      } catch (error) {
        yield LoginFailureState(errorMessage: error.toString());
      }
    }
  }
}
