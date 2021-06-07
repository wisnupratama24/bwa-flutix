import 'package:bwa_flutix/services/services.dart';
import 'package:bwa_flutix/shared/shared.dart';
import 'package:bwa_flutix/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    bottomNavIndex = 0;
    pageController = PageController(initialPage: bottomNavIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8,
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: mainColor,
              unselectedItemColor: accentColor4,
              currentIndex: bottomNavIndex,
              onTap: (index) {
                setState(() {
                  bottomNavIndex = index;
                  pageController.jumpToPage(index);
                });
              },
              items: [
                customBottomNavigationBarItem(
                    isActive: 0, icon: 'ic_movie', label: 'New Movie'),
                customBottomNavigationBarItem(
                    isActive: 1, icon: 'ic_tickets', label: 'My Ticket'),
              ],
            )),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: accentColor2,
          child: Icon(
            Icons.play_for_work,
            color: Colors.grey[800],
          ),
          onPressed: () async {
            await AuthServices().signOut();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Stack(
          children: [
            Container(
              color: accentColor1,
            ),
            SafeArea(
                child: Container(
              color: greyHomeColor,
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    bottomNavIndex = index;
                  });
                },
                children: [
                  MoviePage(),
                  Center(
                    child: Text('My Ticket'),
                  ),
                ],
              ),
            )),

            // CustomBottomNavigator(),
          ],
        ));
  }

  BottomNavigationBarItem customBottomNavigationBarItem(
      {int isActive, String icon, String label}) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.only(bottom: 6),
        height: 18,
        width: 24,
        child: Image.asset((bottomNavIndex == isActive
            ? "assets/$icon.png"
            : "assets/${icon}_grey.png")),
      ),
      label: label,
    );
  }
}
