import 'package:firebasegoogle/pages/components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({Key? key,required VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 45,
      child: RoundedButton(
        text:"Register" ,
        press: (){
          this._onPressed();
          Navigator.of(context).pop();
        },
      )
    );
  }
}