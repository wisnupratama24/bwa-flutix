import 'package:bwa_flutix/bloc/blocs.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  AuthServices _authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) => (userState is UserLoaded)
                    ? Text(userState.user.name)
                    : Text('Loaded')),
            RaisedButton(
              child: Text('Sign Out'),
              onPressed: () async {
                SignInSignUpResult result = await _authServices.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
