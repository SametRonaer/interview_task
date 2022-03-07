import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task/extensions/screen_size_context.dart';
import 'package:interview_task/helpers/validation_service.dart';
import 'package:interview_task/providers/auth_provider.dart';
import 'package:interview_task/screens/login_screen.dart';
import 'package:interview_task/widgets/app_loading_spinner.dart';
import 'package:interview_task/widgets/custom_app_button.dart';
import 'package:interview_task/widgets/custom_app_text_field.dart';
import 'package:provider/provider.dart';

import '../constants/enums.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  static const routeName = "/sign-up-screen";
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late AuthProvider authProvider;
  late ScreenStates _screenState;
  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    _screenState = authProvider.authState;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Sign Up",
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
                      validator: ValidationService.checkEmail,
                      controller: _emailController,
                    ),
                    CustomTextField.password(
                      controller: _passwordController,
                      validator: ValidationService.checkPassword,
                    ),
                    CustomTextField.password(
                      hintText: "Re Password",
                      controller: _confirmPasswordController,
                      validator: ValidationService.checkPassword,
                    ),
                    CustomAppButton.dark(
                      buttonName: "Register",
                      buttonFunction: () {
                        if (_formKey.currentState!.validate()) {
                          authProvider.signUp(
                              _emailController.text,
                              _passwordController.text,
                              _confirmPasswordController.text,
                              context);
                        }
                      },
                    ),
                    CustomAppButton.light(
                      buttonName: "Login",
                      buttonFunction: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
