import 'package:campuscollaborate/services/drop_down_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/themes.dart';

typedef DropDownFunctionType = Function(String? value);

class CustomDropDownButton extends StatelessWidget {
  final TextEditingController textEditingController;
  const CustomDropDownButton({super.key, required this.textEditingController});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time Taken',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      border: InputBorder.none,
                      hintText: 'Leave blank if new Project',
                      hintStyle: TextStyle(
                          fontSize: 13,
                          color:
                              Themes.getColors(ColorsValues.LIGHT_TEXT_COLOR))),
                  controller: textEditingController,
                  cursorColor: Themes.getColors(ColorsValues.ORANGE_COLOR),
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 90,
              decoration: BoxDecoration(
                color: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Consumer<DropDownServices>(
                  builder: (context, services, child) => DropdownButton<String>(
                    items: DropDownServices.durationItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: services.selectedValue,
                    onChanged: (value) {
                      if (value != null) {
                        services.setValue(value);
                      }
                    },
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Image.asset('assets/dropdown.png'),
                    ),
                    underline: const SizedBox(
                      height: 0,
                    ),
                    dropdownColor:
                        Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
