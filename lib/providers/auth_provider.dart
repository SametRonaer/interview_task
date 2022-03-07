import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:interview_task/constants/enums.dart';
import 'package:interview_task/helpers/api_service.dart';
import 'package:interview_task/models/response_model.dart';
import 'package:interview_task/providers/content_provider.dart';
import 'package:interview_task/providers/profile_provider.dart';
import 'package:interview_task/screens/bottom_bar_screen.dart';
import 'package:interview_task/screens/login_screen.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  ScreenStates authState = ScreenStates.Initial;
  String? _token;
  String? get getUserToken => _token;

  AuthProvider() {
    _token = GetStorage().read("Token");
  }

  Future<void> checkTokenStatus(BuildContext context) async {
    if (_token == null) {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    } else {
      await _setAppConfig(context, _token!);
      Navigator.of(context).pushReplacementNamed(BottomBarScreen.routeName);
    }
  }

  Future<void> _setUserToken(String token) async {
    await GetStorage().write("Token", token);
  }

  Future<void> logIn(
      String email, String password, BuildContext context) async {
    authState = ScreenStates.Loading;
    notifyListeners();
    Map<String, String> _userData = {"Email": email, "Password": password};
    Map<String, dynamic> response = await ApiService.sendPostRequest(
        endPoint: "/Login/SignIn", postData: _userData) as Map<String, dynamic>;
    await _responseCheck(response, context);
  }

  Future<void> logOut(BuildContext context) async {
    GetStorage().remove("Token");
    Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName,
        (route) => route.settings.name == LoginScreen.routeName);
  }

  Future<void> signUp(String email, String password, String confirmPassword,
      BuildContext context) async {
    authState = ScreenStates.Loading;
    notifyListeners();
    Map<String, String> _userData = {
      "Email": email,
      "Password": password,
      "PasswordRetry": confirmPassword
    };
    Map<String, dynamic>? response = await ApiService.sendPostRequest(
        endPoint: "/Login/SignUp",
        postData: _userData) as Map<String, dynamic>?;
    await _responseCheck(response, context);
  }

  Future<void> _responseCheck(
      Map<String, dynamic>? response, BuildContext context) async {
    if (response != null) {
      ResponseModel authResponse = ResponseModel.fromJson(response);
      if (authResponse.hasError!) {
        authState = ScreenStates.Error;
        notifyListeners();
      } else {
        _token = authResponse.data["Token"];
        authState = ScreenStates.Success;
        await _setUserToken(_token!);
        await _setAppConfig(context, _token!);
        notifyListeners();
        Navigator.of(context).pushReplacementNamed(BottomBarScreen.routeName);
      }
    } else {
      authState = ScreenStates.Error;
      notifyListeners();
    }
  }

  Future<void> _setAppConfig(BuildContext context, String token) async {
    ContentProvider contentProvider =
        Provider.of<ContentProvider>(context, listen: false);
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    await Future.delayed(const Duration(seconds: 1));
    await profileProvider.setAccountData(token);
    await contentProvider.setCategories(token);
    await contentProvider.setFavoriteBlogs(context);
    await contentProvider.getAllBlogs(token);
  }
}
