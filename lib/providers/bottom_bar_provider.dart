import 'package:flutter/cupertino.dart';
import 'package:interview_task/constants/enums.dart';
import 'package:interview_task/providers/auth_provider.dart';
import 'package:interview_task/providers/content_provider.dart';
import 'package:interview_task/providers/profile_provider.dart';
import 'package:interview_task/screens/bottom_bar_screen.dart';
import 'package:interview_task/screens/favorities_screen.dart';
import 'package:interview_task/screens/home_screen.dart';
import 'package:interview_task/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class BottomBarProvider extends ChangeNotifier {
  Widget currentScreen = HomeScreen();
  int currentScreenIndex = 1;
  ScreenStates bottomBarState = ScreenStates.Initial;

  switchScreen(int selectedScreenIndex, BuildContext context) async {
    Navigator.of(context).maybePop();
    switch (selectedScreenIndex) {
      case 0:
        bottomBarState = ScreenStates.Loading;
        notifyListeners();
        currentScreenIndex = 0;
        currentScreen = FavoritiesScreen();
        await _setFavoritiesScreen(context);
        bottomBarState = ScreenStates.Success;
        notifyListeners();
        break;
      case 1:
        currentScreenIndex = 1;
        currentScreen = HomeScreen();
        notifyListeners();
        break;
      case 2:
        currentScreenIndex = 2;
        currentScreen = ProfileScreen();
        notifyListeners();
        break;
      default:
        currentScreenIndex = 1;
        currentScreen = HomeScreen();
        notifyListeners();
        break;
    }
  }

  Future<void> _setFavoritiesScreen(BuildContext context) async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).getUserToken!;
    Provider.of<ContentProvider>(context, listen: false)
        .setFavoriteBlogs(context);
  }
}
