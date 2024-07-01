import 'package:flutter/material.dart';

import '../../constants/themes.dart';

class FormTextFieldContainer extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController textEditingController;
  final int? maxLines;
  final String?Function(String?)? validator;
  const FormTextFieldContainer(
      {super.key,
      required this.hintText,
      required this.title,
      required this.textEditingController,
      this.maxLines,
        this.validator
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: TextFormField(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                    fontSize: 13,
                    color: Themes.getColors(ColorsValues.LIGHT_TEXT_COLOR))),
            controller: textEditingController,
            cursorColor: Themes.getColors(ColorsValues.ORANGE_COLOR),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            maxLines: maxLines ?? 1,
            validator: validator ?? (val){
              if(val==null||val.isEmpty){
                return 'This field cannot remain empty';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
