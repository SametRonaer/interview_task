import 'package:flutter/material.dart';
import 'package:interview_task/extensions/screen_size_context.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController? controller;
  IconData? prefixIcon;
  Widget? suffixWidget;
  String? hintText;
  bool isPassword = false;
  String? Function(String?)? validator;

  CustomTextField(
      {this.controller,
      this.prefixIcon,
      this.suffixWidget,
      this.hintText,
      this.validator});

  CustomTextField.password({this.controller, this.validator, this.hintText}) {
    isPassword = true;
  }

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hideText = true;
  Color iconColor = Colors.grey.shade400;
  @override
  Widget build(BuildContext context) {
    return widget.isPassword
        ? Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.screenWidth / 25,
                vertical: context.screenHeight / 100),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                _getOutline(context),
                TextFormField(
                  validator: widget.validator,
                  controller: widget.controller,
                  obscureText: hideText,
                  decoration: InputDecoration(
                      // errorStyle: TextStyle(l),
                      errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: iconColor,
                      ),
                      suffixIcon: IconButton(
                          onPressed: (() {
                            setState(() {
                              hideText = !hideText;
                            });
                          }),
                          icon: Icon(
                            hideText ? Icons.visibility_off : Icons.visibility,
                            color: iconColor,
                          )),
                      hintText: widget.hintText ?? "Password",
                      hintStyle: TextStyle(color: iconColor, fontSize: 14),
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      )),
                )
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.screenWidth / 25,
                vertical: context.screenHeight / 100),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                _getOutline(context),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: widget.validator,
                  controller: widget.controller,
                  decoration: InputDecoration(
                    errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    prefixIcon: Icon(
                      widget.prefixIcon,
                      color: iconColor,
                    ),
                    suffixIcon: widget.suffixWidget,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(color: iconColor, fontSize: 14),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Container _getOutline(BuildContext context) {
    return Container(
      height: context.screenHeight / 14,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.3, color: Colors.grey.shade500)),
      padding: const EdgeInsets.symmetric(vertical: 5),
    );
  }
}
