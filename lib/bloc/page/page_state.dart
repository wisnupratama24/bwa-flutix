part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class OnInitialPage extends PageState {}

class OnSignInPage extends PageState {}

class OnSplashPage extends PageState {}

class OnMainPage extends PageState {}

class OnRegistrationPage extends PageState {
  final RegistrationData registrationData;

  OnRegistrationPage(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class OnPreferencePage extends PageState {
  final RegistrationData registrationData;

  OnPreferencePage(this.registrationData);
}

class OnAccounConfirmationPage extends PageState {
  final RegistrationData registrationData;

  OnAccounConfirmationPage(this.registrationData);
}
