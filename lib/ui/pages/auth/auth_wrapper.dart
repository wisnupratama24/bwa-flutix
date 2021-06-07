part of '../pages.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    if (user != null) {
      if (!(prevPageEvent is GoToMainPage)) {
        context.read<UserBloc>().add(LoadUser(user.uid));
        prevPageEvent = GoToMainPage();
        context.read<PageBloc>().add(GoToMainPage());
      }
    } else {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.read<PageBloc>().add(GoToSplashPage());
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnSignInPage)
                ? SignInPage()
                : (pageState is OnRegistrationPage)
                    ? SignUpPage()
                    : MainPage());
  }
}
