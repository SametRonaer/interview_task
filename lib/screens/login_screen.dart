import 'package:flutter/material.dart';
import 'package:interview_task/constants/enums.dart';
import 'package:interview_task/extensions/screen_size_context.dart';
import 'package:interview_task/helpers/validation_service.dart';
import 'package:interview_task/providers/auth_provider.dart';
import 'package:interview_task/providers/content_provider.dart';
import 'package:interview_task/routing/app_router.dart';
import 'package:interview_task/screens/bottom_bar_screen.dart';
import 'package:interview_task/screens/sign_up_screen.dart';
import 'package:interview_task/widgets/app_loading_spinner.dart';
import 'package:interview_task/widgets/custom_app_button.dart';
import 'package:interview_task/widgets/custom_app_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/login-screen";
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AuthProvider authProvider;
  late ContentProvider? contentProvider;
  late ScreenStates _screenState;

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    _screenState = authProvider.authState;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: _screenState == ScreenStates.Loading
          ? const AppLoadingSpinner()
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: context.screenHeight / 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey),
                      height: context.screenHeight / 4.5,
                      width: context.screenHeight / 4.5,
                    ),
                    CustomTextField(
                      hintText: "Email",
                      prefixIcon: Icons.mail,
                      controller: _emailController,
                      validator: ValidationService.checkEmail,
                    ),
                    CustomTextField.password(
                      hintText: "Password",
                      controller: _passwordController,
                      validator: ValidationService.checkPassword,
                    ),
                    CustomAppButton.dark(
                      buttonName: "Login",
                      buttonFunction: () {
                        if (_formKey.currentState!.validate()) {
                          authProvider.logIn(_emailController.text,
                              _passwordController.text, context);
                        }
                      },
                    ),
                    CustomAppButton.light(
                      buttonName: "Register",
                      buttonFunction: () {
                        Navigator.of(context)
                            .pushReplacementNamed(SignUpScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
