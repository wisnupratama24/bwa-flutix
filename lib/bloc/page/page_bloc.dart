import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/models/registration_data.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnInitialPage());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToLoginPage) {
      yield OnSignInPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage();
    } else if (event is GoToRegistrationPage) {
      print("event ${event.registrationData}");
      yield OnRegistrationPage(event.registrationData);
    } else if (event is GoToPreferencePage) {
      yield OnPreferencePage(event.registrationData);
    } else if (event is GoToAccountConfirmationPage) {
      yield OnAccounConfirmationPage(event.registrationData);
    }
  }
}
