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
