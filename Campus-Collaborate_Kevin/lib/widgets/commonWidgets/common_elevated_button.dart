import 'package:campuscollaborate/constants/themes.dart';
import 'package:flutter/material.dart';

class CommonGesturizedButton extends StatelessWidget {
  final void Function() onPressed;
  final Text buttonText;
  const CommonGesturizedButton(
      {super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10, right: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buttonText,
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}

class CommonElevatedButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const CommonElevatedButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Themes.getColors(ColorsValues.ORANGE_COLOR),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            )
          ),
          child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      )),
    );
  }
}

