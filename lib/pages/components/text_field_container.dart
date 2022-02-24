import 'package:firebasegoogle/constants.dart';
import 'package:flutter/cupertino.dart';
class TextfieldContainer extends StatelessWidget{
  final Widget? child;
  const TextfieldContainer({
    Key? key,
    this.child,
}) :super(key:key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}