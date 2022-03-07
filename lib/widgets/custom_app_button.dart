import 'package:flutter/material.dart';
import 'package:interview_task/extensions/screen_size_context.dart';

class CustomAppButton extends StatelessWidget {

   String buttonName;
   late Color buttonColor;
   late Color textColor;
   IconData? icondata;
   void Function() buttonFunction;
   
   CustomAppButton.light({Key? key, this.icondata, required this.buttonFunction, required this.buttonName}) : super(key: key){
    buttonColor = Colors.white;
    textColor = Colors.black;
  }

   CustomAppButton.dark({Key? key, this.icondata, required this.buttonFunction, required this.buttonName}) : super(key: key){
    buttonColor = Colors.black;
    textColor = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonFunction,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icondata ?? Icons.logout, color: textColor,),
              ],
            ),
            Text(buttonName, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w400),),
          ],
        ),
        
        height:  context.screenHeight/14,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: context.screenWidth/25, vertical: context.screenHeight/100),
        decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(15), border: Border.all(width: 1.3 ,color: Colors.black))
      ),
    );
  }
}