part of '../pages.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        padding: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 44),
        decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) => (userState is UserLoaded)
                    ? Container(
                        child: Row(
                          children: [
                            ProfileUser(
                              user: userState.user,
                            ),
                            SizedBox(
                              width: defaultMargin,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    userState.user.name.capitalize(),
                                    style: whiteTextFont.copyWith(fontSize: 18),
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  NumberFormat.currency(
                                          symbol: 'IDR ',
                                          locale: 'id_ID',
                                          decimalDigits: 0)
                                      .format(userState.user.balance),
                                  style: yellowNumberFont.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    : LoadWidget())
          ],
        ),
      ),
    ]);
  }
}

class ProfileUser extends StatelessWidget {
  final UserModel user;
  const ProfileUser({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: Color(0xFf5F558B))),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: user.profile == null
                    ? AssetImage('assets/user_pic.png')
                    : AssetImage('assets/user_pic.png'))),
      ),
    );
  }
}
