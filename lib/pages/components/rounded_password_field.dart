import 'package:firebasegoogle/pages/components/text_field_container.dart';
import 'package:firebasegoogle/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RoundedPasswordField extends StatelessWidget {
  final String? labelText;
  final IconData icon;
  final FormFieldValidator validator;
  final TextEditingController controller;
  RoundedPasswordField({
    Key? key,
    this.labelText,
    this.icon = Icons.lock,
    required this.validator,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextfieldContainer(
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: true,
        autovalidate: true,
        autocorrect: false,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          labelText:  'Enter your Password',
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}