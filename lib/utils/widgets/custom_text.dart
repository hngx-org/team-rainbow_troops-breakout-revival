import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      required this.onpressed,
      required this.color});

  final String text;
  final void Function() onpressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onpressed,
        child: Text(
          text,
          style: TextStyle(
              color: color, fontWeight: FontWeight.w500, fontSize: 18.0),
        ));
  }
}
