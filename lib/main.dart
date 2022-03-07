import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:interview_task/providers/auth_provider.dart';
import 'package:interview_task/providers/bottom_bar_provider.dart';
import 'package:interview_task/providers/content_provider.dart';
import 'package:interview_task/providers/profile_provider.dart';
import 'package:interview_task/routing/app_router.dart';
import 'package:provider/provider.dart';

void main() async {
  await GetStorage.init();
  runApp(const InterviewApp());
}

class InterviewApp extends StatelessWidget {
  const InterviewApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider()),
        ChangeNotifierProvider<BottomBarProvider>.value(
            value: BottomBarProvider()),
        ChangeNotifierProvider<ContentProvider>.value(value: ContentProvider()),
        ChangeNotifierProvider<ProfileProvider>.value(value: ProfileProvider()),
      ],
      child: const GetMaterialApp(
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
