import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.onPress,
      this.isLoading = false,
      required this.buttonchild,
      required this.height,
      required this.width});

  final void Function()? onPress;
  final bool? isLoading;
  final String buttonchild;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: TextButton(
          onPressed: onPress,
          child: Text(
            buttonchild,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          style: TextButton.styleFrom(
              minimumSize: Size(width, height),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              side: BorderSide(width: 1.0, color: Color(0xff666B80)),
              backgroundColor: Color(0xff303B52)),
        ));
  }
}
