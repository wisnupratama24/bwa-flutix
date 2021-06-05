part of 'pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 136,
                    margin: EdgeInsets.only(bottom: 70, top: height * 0.23),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/logo.png'))),
                  ),
                  Text(
                    "New Experience",
                    style: blackTextFont.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      "Watch a new movie much\neasier than any before",
                      textAlign: TextAlign.center,
                      style: blackTextFont.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    width: 250,
                    margin: EdgeInsets.only(top: 70),
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton(
                      onPressed: () {
                        context.read<PageBloc>().add(GoToLoginPage());
                      },
                      child: Text(
                        'Get Started',
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: greyTextFont.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<PageBloc>().add(GoToLoginPage());
                          },
                          child: Text(
                            'Sign in',
                            style: purpleTextFont.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
