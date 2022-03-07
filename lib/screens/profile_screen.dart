import 'package:flutter/material.dart';
import 'package:interview_task/extensions/screen_size_context.dart';
import 'package:interview_task/providers/auth_provider.dart';
import 'package:interview_task/providers/profile_provider.dart';
import 'package:interview_task/widgets/custom_app_button.dart';
import 'package:interview_task/widgets/image_scelection_window.dart';
import 'package:interview_task/widgets/map_window.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  late ProfileProvider profileProvider;
  late AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: _getAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getAvatarPick(context),
            MapWindow(),
            CustomAppButton.light(
                buttonFunction: () async {
                  await profileProvider.updateUser(context);
                },
                buttonName: "Save"),
            CustomAppButton.dark(
                buttonFunction: () {
                  authProvider.logOut(context);
                },
                buttonName: "Log Out"),
          ],
        ),
      ),
    );
  }

  Widget _getAvatarPick(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await profileProvider.sendStoragePermission();
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            isScrollControlled: true,
            context: context,
            builder: (_) {
              return ImageSelectionWindow();
            });
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: _getAvatarImage(),
              radius: context.screenWidth / 4.5,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: context.screenWidth / 4, top: context.screenWidth / 4),
              child: Icon(
                Icons.photo_camera,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      title: Text(
        "MyProfile",
        style: TextStyle(color: Colors.black, fontSize: 17),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
    );
  }

  ImageProvider? _getAvatarImage() {
    if (profileProvider.avatarPreviewImage != null) {
      return FileImage(profileProvider.avatarPreviewImage!);
    } else if (profileProvider.getCurrentUser!.Image != null) {
      return NetworkImage(profileProvider.getCurrentUser!.Image.toString());
    }
    return null;
  }
}
