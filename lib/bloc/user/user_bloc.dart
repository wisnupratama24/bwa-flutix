import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/models/user_model.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      UserModel userModel = await UserService().getUser(event.id);
      yield UserLoaded(userModel);
    } else if (event is SignOut) {
      yield UserInitial();
    }
  }
}
