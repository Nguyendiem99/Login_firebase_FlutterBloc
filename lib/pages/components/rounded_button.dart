import 'package:firebasegoogle/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget{
  final String? text;
  final Function()? press;
  final Color color;
  final Color textcolor ;
  final Icon? icon;
  const RoundedButton({
    Key? key,
    this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textcolor = Colors.white,
    this.icon
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width *0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child:  newElevateButton(),
      ),
    );
  }
  Widget newElevateButton(){
    return ElevatedButton(
        onPressed: press,
        child: Text(
          text!,
          style: TextStyle(color: textcolor),
        ),
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
        textStyle: TextStyle(
          color: textcolor,fontSize: 14,fontWeight: FontWeight.w500
        )
      ),
    );
  }
}