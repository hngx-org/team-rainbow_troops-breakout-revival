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
          style: TextButton.styleFrom(
              minimumSize: Size(width, height),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              side: const BorderSide(width: 1.0, color: Color(0xff666B80)),
              backgroundColor: const Color(0xff303B52)),
          child: Text(
            buttonchild,
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ));
  }
}
