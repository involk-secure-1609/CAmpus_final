import 'package:campuscollaborate/constants/themes.dart';
import 'package:flutter/material.dart';

typedef ToggleFunctionType = Function(int? value);

class CustomToggleButton extends StatelessWidget {
  final List<bool> isSelected;
  final ToggleFunctionType onChange;
  final String firstToggleText;
  final String secondToggleText;
  const CustomToggleButton(
      {super.key,
      required this.onChange,
      required this.isSelected,
      required this.firstToggleText,
      required this.secondToggleText});

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: isSelected,
      selectedColor: Themes.getColors(ColorsValues.BACKGROUND_COLOR),
      fillColor: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      selectedBorderColor: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
      constraints:  BoxConstraints(
        minHeight: 40,
        minWidth: MediaQuery.of(context).size.width * 0.4,
      ),
      borderWidth: 2,
      borderColor: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
      onPressed: onChange,
      children: [
        Text(
          firstToggleText,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          secondToggleText,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
