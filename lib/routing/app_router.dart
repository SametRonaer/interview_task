import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interview_task/screens/article_detail_screen.dart';
import 'package:interview_task/screens/bottom_bar_screen.dart';
import 'package:interview_task/screens/login_screen.dart';
import 'package:interview_task/screens/sign_up_screen.dart';
import 'package:interview_task/screens/splash_screen.dart';

class AppRouter {


 static  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => LoginScreen());
      case SignUpScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => SignUpScreen());
      case BottomBarScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BottomBarScreen());
      case ArticleDetailScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => ArticleDetailScreen());
      case SplashScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const SplashScreen());
       default:
        return MaterialPageRoute(
            builder: (_) => const SplashScreen());
  }
  
  }
}