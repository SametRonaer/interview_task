import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:interview_task/extensions/screen_size_context.dart';
import 'package:interview_task/providers/auth_provider.dart';
import 'package:interview_task/providers/profile_provider.dart';
import 'package:interview_task/widgets/custom_app_button.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class ImageSelectionWindow extends StatefulWidget {
  const ImageSelectionWindow({Key? key}) : super(key: key);
  

  @override
  State<ImageSelectionWindow> createState() => _ImageSelectionWindowState();
}

class _ImageSelectionWindowState extends State<ImageSelectionWindow> {
  Widget? currentScreen;
  late AuthProvider authProvider;
  late ProfileProvider profileProvider;
  var userImage;
  bool imageSelected = false;
  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    profileProvider = Provider.of<ProfileProvider>(context);
    return Container(
      height: context.screenHeight / 1.3,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: 
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  Container(
                     margin: EdgeInsets.only(top: 10, bottom: 20),
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade400),
                    width: context.screenWidth / 1.03,
                    height: context.screenWidth / 1.1,
                    child: userImage != null ? Image.file(userImage) : null,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: CustomAppButton.dark(
                        buttonFunction: (){
                         Navigator.of(context).pop();
                        },
                        buttonName: "Select",
                      )),
                      Flexible(
                          child: CustomAppButton.light(
                        buttonFunction: () async {
                        profileProvider.setAvatarPreviewImage(null);
                        Navigator.of(context).pop();
                        },
                        buttonName: "Remove",
                      )),
                    ],
                  ),
                ],
              ),
              if(!imageSelected)
               Container(height:context.screenHeight/4, width: context.screenWidth/1.3, 
               margin: EdgeInsets.only(top: 15),
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color:Colors.white),
               child:   Column(
                 children: [
                   Flexible(
                     flex: 1,
                     child: Expanded(child: Container(
                       alignment: Alignment.center,
                       child: Text("Select a Picture", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),)))),
                    Flexible(
                          child: CustomAppButton.dark(
                            icondata: Icons.photo_camera,
                          buttonFunction: () async{
                            setState(() {
                            imageSelected = true;
                            });
                          await _openCamera();
                        },
                        buttonName: "Camera",
                      )),
                      Flexible(
                      child: CustomAppButton.light(
                        icondata: Icons.image,
                      buttonFunction: () async {
                         setState(() {
                            imageSelected = true;
                            });
                       await _openGallery();
                      },
                      buttonName: "Gallery",
                    )),
                 ],
               ),
               ),
            ],
          ),
    );
  }

    _openCamera()async{
     final ImagePicker _picker = ImagePicker();
     final XFile? photo = await _picker.pickImage(source: ImageSource.camera, imageQuality: 30);
     if(photo != null){
      setState(() {
      userImage = File(photo.path);
      profileProvider.setAvatarPreviewImage(userImage);
      });
     }
  }

    _openGallery()async{
     final ImagePicker _picker = ImagePicker();
     final XFile? photo = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
     if(photo != null){
      setState(() {
      userImage = File(photo.path);
      profileProvider.setAvatarPreviewImage(userImage);
      });
     }
  }



}