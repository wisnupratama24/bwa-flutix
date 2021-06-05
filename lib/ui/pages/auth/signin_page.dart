import 'package:bwa_flutix/bloc/blocs.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:bwa_flutix/shared/shared.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // TextEditingController textFieldEmail;
  // TextEditingController textFieldPassword;
  final textFieldEmail = TextEditingController();
  final textFieldPassword = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigninIn = false;

  @override
  void dispose() {
    textFieldEmail.dispose();
    textFieldPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: SizedBox(
                      height: 70,
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    "Welcome Back,\nExplorer!",
                    style: blackTextFont.copyWith(
                        height: 1.7, fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: textFieldEmail,
                    onChanged: (text) {
                      setState(() {
                        isEmailValid = EmailValidator.validate(text);
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Email Address',
                        hintText: 'Email Address'),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  TextField(
                    controller: textFieldPassword,
                    onChanged: (text) {
                      setState(() {
                        isPasswordValid = text.length >= 6;
                      });
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Password',
                        hintText: 'Password'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      height: 70,
                      child: FloatingActionButton(
                        elevation: 0.0,
                        backgroundColor: isEmailValid && isPasswordValid
                            ? mainColor
                            : accentColor4,
                        child: Container(
                          child: Icon(Icons.arrow_forward_outlined),
                        ),
                        onPressed: isEmailValid &&
                                isPasswordValid &&
                                isSigninIn == false
                            ? () async {
                                setState(() {
                                  isSigninIn = true;
                                });
                                SignInSignUpResult result = await AuthServices()
                                    .signIn(textFieldEmail.text,
                                        textFieldPassword.text);
                                if (result.user == null) {
                                  _showFlash(
                                      duration: Duration(seconds: 2),
                                      message: result.message);
                                  setState(() {
                                    isSigninIn = false;
                                  });
                                }
                              }
                            : null,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Start fresh now?',
                          style: greyTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Sign up',
                          style: purpleTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ),
        ));
  }

  void _showFlash(
      {Duration duration,
      flashStyle = FlashBehavior.floating,
      String message}) {
    showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          behavior: flashStyle,
          backgroundColor: pinkColor,
          position: FlashPosition.top,
          boxShadows: kElevationToShadow[0],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            content: Text(
              message,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
