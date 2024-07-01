import 'package:flutter/material.dart';

import '../../constants/themes.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final Widget? suffix;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final void Function()? onTap;
  final void Function(String value)? onChanged;
  final Widget? prefix;
  const CommonTextField(
      {super.key,
      required this.textEditingController,
        // required this.searchFocusNode,
      required this.hintText,
        this.backgroundColor,
        this.width,
        this.height,
      this.suffix,
      this.onTap,
        this.onChanged,
        this.prefix
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width??double.infinity,
      height: height??45,
      decoration: BoxDecoration(
        color: backgroundColor ?? Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: TextField(
        controller: textEditingController,
        // focusNode: searchFocusNode,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: TextStyle(
                color: Themes.getColors(ColorsValues.LIGHT_TEXT_COLOR),
                fontSize: 13,
                fontWeight: FontWeight.w400),
            suffixIcon: GestureDetector(onTap:onTap ?? (){}, child: suffix,
            ),
          prefix: prefix
        ),
        style: const TextStyle(color: Colors.white, fontSize: 13),
        cursorColor: Themes.getColors(ColorsValues.ORANGE_COLOR),
        onChanged: onChanged,
      ),
    );
  }
}
