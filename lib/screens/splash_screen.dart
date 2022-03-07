import 'package:flutter/material.dart';
import 'package:interview_task/providers/auth_provider.dart';
import 'package:interview_task/widgets/app_loading_spinner.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = "/splash-screen";
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context).checkTokenStatus(context);
    return Scaffold(
      body: AppLoadingSpinner(),
    );
  }
}
