import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interview_task/helpers/api_service.dart';
import 'package:interview_task/models/user_model.dart';
import 'package:interview_task/providers/auth_provider.dart';
import 'package:interview_task/providers/content_provider.dart';
import 'package:location/location.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;
import 'package:provider/provider.dart';

class ProfileProvider extends ChangeNotifier {
  Location location = Location();
  LatLng? userLocation;
  UserModel? _currentUser;
  UserModel? get getCurrentUser => _currentUser;
  File? avatarPreviewImage;

  Future<void> setAccountData(String token) async {
    Map<String, dynamic> response =
        await ApiService.sendGetRequest("/Account/Get", token);
    Map<String, dynamic> userData = response["Data"];
    _currentUser = UserModel.fromMap(userData);
    if (_currentUser!.Location != null) {
      userLocation = LatLng(double.parse(_currentUser!.Location!["Latitude"]),
          double.parse(_currentUser!.Location!["Longtitude"]));
    } else {
      await setOriginalUserLocation();
    }
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(
      String blogId, String token, BuildContext context) async {
    await ApiService.sendPostRequest(
        endPoint: "/Blog/ToggleFavorite",
        postData: {"Id": blogId},
        token: token);
    Provider.of<ContentProvider>(context, listen: false)
        .setFavoriteBlogs(context);
    notifyListeners();
  }

  Future<void> setOriginalUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    userLocation = LatLng(locationData.latitude!, locationData.longitude!);
    notifyListeners();
  }

  Future<void> setNewLocation(LatLng newLocation) async {
    userLocation = newLocation;
    notifyListeners();
  }

  Future<void> updateUser(BuildContext context) async {
    String? imageUrl;
    if (avatarPreviewImage != null) {
      String token =
          Provider.of<AuthProvider>(context, listen: false).getUserToken!;
      imageUrl = await ApiService.uploadImage(avatarPreviewImage!.path, token);
      //await ApiService.uploadImage(photo.path, authProvider.getUserToken!);
    } else if (_currentUser!.Image != null) {
      imageUrl = _currentUser!.Image;
    }
    await ApiService.sendPostRequest(
        endPoint: "/Account/Update",
        postData: {
          "Image": imageUrl,
          "Location": {
            "Longtitude": userLocation!.longitude.toString(),
            "Latitude": userLocation!.latitude.toString()
          }
        },
        token: Provider.of<AuthProvider>(context, listen: false).getUserToken);
    await setAccountData(
        Provider.of<AuthProvider>(context, listen: false).getUserToken!);
  }

  setAvatarPreviewImage(File? image) {
    avatarPreviewImage = image;
    notifyListeners();
  }

  Future<bool> sendStoragePermission() async {
    if (Platform.isIOS &&
            await permissionHandler.Permission.storage.request().isGranted &&
            await permissionHandler.Permission.photos.request().isGranted ||
        Platform.isAndroid &&
            await permissionHandler.Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }
}
