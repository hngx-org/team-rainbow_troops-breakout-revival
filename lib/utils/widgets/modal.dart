import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Modal extends StatelessWidget {
  const Modal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xff3e4c65),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: SizedBox(
        width: 317,
        height: 308,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          // color: Colors.white,
          color: const Color(0xff3e4c65),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/star1.svg",
                    width: 75,
                    height: 75,
                  ),
                  SvgPicture.asset(
                    "assets/images/star1.svg",
                    width: 125,
                    height: 125,
                  ),
                  SvgPicture.asset(
                    "assets/images/star2.svg",
                    width: 75,
                    height: 75,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Level 1",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFA9B6CE)),
              ),
              const SizedBox(height: 10),
              const Text(
                "COMPLETE",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/previous_play_pause.svg", width: 50, height: 50,),
                  const SizedBox(width: 15,),
                  SvgPicture.asset(
                    "assets/images/Button_Continue.svg",
                    // width: 125,
                    // height: 125,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
