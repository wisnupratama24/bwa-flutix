import 'dart:io';

import 'package:bwa_flutix/bloc/blocs.dart';
import 'package:bwa_flutix/models/registration_data.dart';
import 'package:bwa_flutix/shared/shared.dart';
import 'package:bwa_flutix/ui/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;
  SignUpPage({key, this.registrationData}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.registrationData != null) {
      emailController.text = widget.registrationData.email;
      nameController.text = widget.registrationData.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          color: Colors.white,
          child: ListView(
            children: [
              Column(
                children: [
                  CenterBackAndTitle(
                    text: "Create New\nYour Account",
                    onTap: () =>
                        {context.read<PageBloc>().add(GoToLoginPage())},
                  ),
                  Container(
                    width: 90,
                    height: 104,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: widget.registrationData.profile == null
                                      ? AssetImage(defaultUserPict)
                                      : FileImage(
                                          widget.registrationData.profile))),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.registrationData.profile == null) {
                                File pathImage = await getImage();
                                setState(() {
                                  widget.registrationData.profile = pathImage;
                                });
                              } else {
                                setState(() {
                                  widget.registrationData.profile = null;
                                });
                              }
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: widget.registrationData?.profile ==
                                              null
                                          ? AssetImage(btnAddPhoto)
                                          : AssetImage(btnDelPhoto))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 36,
              ),
              TextField(
                controller: nameController,
                onChanged: (text) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Full Name',
                    hintText: 'Full Name'),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: emailController,
                onChanged: (text) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Email Address',
                    hintText: 'Email Address'),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                onChanged: (text) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Password',
                    hintText: 'Password'),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                onChanged: (text) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Confirm Password',
                    hintText: 'Confirm Password'),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: FloatingActionButton(
                  backgroundColor: mainColor,
                  elevation: 0,
                  child: Icon(Icons.arrow_forward_outlined),
                  onPressed: () {
                    if (!(emailController.text != '' &&
                        nameController.text != '' &&
                        passwordController.text != '' &&
                        confirmPasswordController.text != '')) {
                      _showFlash(
                          message: "Please fill all fields",
                          duration: Duration(seconds: 2));
                    } else if (!EmailValidator.validate(emailController.text)) {
                      _showFlash(
                          message: "Wrong formatted email address",
                          duration: Duration(seconds: 2));
                    } else if ((passwordController.text.length < 6 &&
                        confirmPasswordController.text.length < 6)) {
                      _showFlash(
                          message: "Minimum password is 6 character",
                          duration: Duration(seconds: 2));
                    } else if (passwordController.text !=
                        confirmPasswordController.text) {
                      _showFlash(
                          message: "Password don't match",
                          duration: Duration(seconds: 2));
                    } else {
                      imageFileToUpload = widget.registrationData.profile;

                      widget.registrationData.email = emailController.text;
                      widget.registrationData.name = nameController.text;
                      widget.registrationData.password =
                          passwordController.text;

                      context
                          .read<PageBloc>()
                          .add(GoToPreferencePage(widget.registrationData));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showFlash({
    Duration duration,
    flashStyle = FlashBehavior.floating,
    String message,
  }) {
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
