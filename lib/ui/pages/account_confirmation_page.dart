part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;
  AccountConfirmationPage({Key key, this.registrationData}) : super(key: key);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSignUp = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          context
              .read<PageBloc>()
              .add(GoToPreferencePage(widget.registrationData));
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
                      text: "Confirm\nNew Account",
                      onTap: () => {
                        context
                            .read<PageBloc>()
                            .add(GoToPreferencePage(widget.registrationData))
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 90,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: widget.registrationData.profile == null
                              ? AssetImage(defaultUserPict)
                              : FileImage(widget.registrationData.profile))),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Welcome',
                        style: blackTextFont.copyWith(fontSize: 16),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(widget.registrationData.name.capitalize(),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: blackTextFont.copyWith(
                              fontSize: 28, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 110,
                ),
                (isSignUp)
                    ? LoadWidget(
                        color: mainColor,
                      )
                    : Container(
                        width: width * 0.6,
                        height: 50,
                        decoration: BoxDecoration(
                            color: greenButtonColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextButton(
                            onPressed: () async {
                              setState(() {
                                isSignUp = true;
                              });

                              SignInSignUpResult result = await AuthServices()
                                  .signUp(
                                      widget.registrationData.email,
                                      widget.registrationData.password,
                                      widget.registrationData.name,
                                      widget.registrationData.language,
                                      widget.registrationData.genre,
                                      0,
                                      "");
                              if (result.user != null) {
                                setState(() {
                                  isSignUp = false;
                                });
                              } else {
                                print(result.message);
                              }
                            },
                            child: Text("Create My Account",
                                style: whiteTextFont.copyWith(fontSize: 16))),
                      )
              ],
            ),
          ),
        ));
  }
}
