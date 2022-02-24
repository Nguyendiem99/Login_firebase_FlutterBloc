import 'package:firebasegoogle/pages/components/text_field_container.dart';
import 'package:firebasegoogle/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RoundedInputField extends StatelessWidget {
  final String? labelText;
  final IconData icon;
  final FormFieldValidator validator;
  final TextEditingController controller;
  RoundedInputField({
    Key? key,
    this.labelText,
    this.icon = Icons.person,
    required this.validator,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextfieldContainer(
      child: TextFormField(
        validator: validator,
        controller: controller,
        autovalidate: true,
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          labelText:  'Enter your email',
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}