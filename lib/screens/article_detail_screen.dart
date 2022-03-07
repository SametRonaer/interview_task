import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:interview_task/providers/bottom_bar_provider.dart';
import 'package:interview_task/providers/content_provider.dart';
import 'package:interview_task/providers/profile_provider.dart';
import 'package:interview_task/widgets/app_loading_spinner.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class ArticleDetailScreen extends StatelessWidget {
  ArticleDetailScreen({Key? key}) : super(key: key);
  static const routeName = "/article-detail-screen";
  late ContentProvider contentProvider;
  late ProfileProvider profileProvider;
  late AuthProvider authProvider;
  late BottomBarProvider bottomBarProvider;

  @override
  Widget build(BuildContext context) {
    contentProvider = Provider.of<ContentProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);
    bottomBarProvider = Provider.of<BottomBarProvider>(context);

    int favoritesLength =
        profileProvider.getCurrentUser!.FavoriteBlogIds.length;
    Widget? badgeContent;
    String badgeText = favoritesLength.toString();
    badgeContent = Text(badgeText, style: TextStyle(color: Colors.white));
    bool badgeVisible = favoritesLength > 0;

    return Scaffold(
      appBar: _getAppBar(context),
      bottomNavigationBar: _getBottomBar(context, badgeVisible, badgeContent),
      body: contentProvider.getCurrentBlog == null
          ? const AppLoadingSpinner()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                      tag: contentProvider.getCurrentBlog!.Id,
                      child:
                          Image.network(contentProvider.getCurrentBlog!.Image)),
                  Html(
                    data: contentProvider.getCurrentBlog!.Content,
                  ),
                ],
              ),
            ),
    );
  }

  BottomNavigationBar _getBottomBar(
      BuildContext context, bool badgeVisible, Widget badgeContent) {
    return BottomNavigationBar(
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
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ]);
  }

  AppBar _getAppBar(BuildContext context) {
    Color iconColor = Colors.grey.shade200;
    if (profileProvider.getCurrentUser!.FavoriteBlogIds
        .contains(contentProvider.getCurrentBlog!.Id)) {
      iconColor = Colors.black;
    }
    return AppBar(
      elevation: 1,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black,
                  ))),
          const Flexible(
              flex: 8,
              child: Text(
                "Article Detail",
                style: TextStyle(color: Colors.black, fontSize: 17),
              )),
          Flexible(
              child: IconButton(
                  onPressed: () async {
                    await profileProvider.toggleFavoriteStatus(
                        contentProvider.getCurrentBlog!.Id,
                        authProvider.getUserToken!,
                        context);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: iconColor,
                  ))),
        ],
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
    );
  }
}
