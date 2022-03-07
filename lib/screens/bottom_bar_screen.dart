import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:interview_task/providers/bottom_bar_provider.dart';
import 'package:interview_task/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({Key? key}) : super(key: key);
  static const routeName = "bottom-bar-screen";

  late BottomBarProvider bottomBarProvider;
  late ProfileProvider profileProvider;
  late int screenIndex;
  @override
  Widget build(BuildContext context) {
    bottomBarProvider = Provider.of<BottomBarProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    screenIndex = bottomBarProvider.currentScreenIndex;
    return _getBottomBar(context);
  }

  Scaffold _getBottomBar(BuildContext context) {
    int favoritesLength =
        profileProvider.getCurrentUser!.FavoriteBlogIds.length;
    Widget? badgeContent;
    String badgeText = favoritesLength.toString();
    badgeContent = Text(badgeText, style: TextStyle(color: Colors.white));
    bool badgeVisible = favoritesLength > 0;

    return Scaffold(
      body: bottomBarProvider.currentScreen,
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) => bottomBarProvider.switchScreen(index, context),
          currentIndex: bottomBarProvider.currentScreenIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade300,
          items: [
            BottomNavigationBarItem(
              icon: Badge(
                  showBadge: badgeVisible,
                  child: Icon(Icons.favorite),
                  badgeContent: badgeContent),
              label: "Favorites",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}
