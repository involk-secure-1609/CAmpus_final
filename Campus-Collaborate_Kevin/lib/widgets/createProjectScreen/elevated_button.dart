import 'package:campuscollaborate/constants/themes.dart';
import 'package:flutter/material.dart';

class AddElevatedButton extends StatelessWidget {
  final void Function() onTap;
  final String buttonText;
  final Image prefixImage;
  const AddElevatedButton(
      {super.key,
      required this.buttonText,
      required this.onTap,
      required this.prefixImage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                foregroundColor:
                    Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
                backgroundColor:
                    Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: prefixImage,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    buttonText,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
