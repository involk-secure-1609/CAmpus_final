import 'package:campuscollaborate/constants/skills.dart';
import 'package:campuscollaborate/constants/themes.dart';
import 'package:campuscollaborate/main.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:campuscollaborate/constants/courses.dart';
class MultipleSelectionDropDown extends StatelessWidget {
  final MultiSelectController multiSelectDropDown;
  const MultipleSelectionDropDown({super.key, required this.multiSelectDropDown});

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
        fieldBackgroundColor: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
        optionsBackgroundColor: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
        optionTextStyle: const TextStyle(color: Colors.white),
        selectedOptionBackgroundColor: Colors.black,
        controller: multiSelectDropDown,
        onOptionSelected: (val){
            debugPrint(val.toString());
        },
        dropdownBorderRadius: 12.0,
        searchEnabled: true,
        searchBackgroundColor:Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
        dropdownBackgroundColor:Themes.getColors(ColorsValues.LIGHT_GREY_COLOR) ,
        options: getValuesFromEnum());
  }
}
class MultipleSelectionCourseDropDown extends StatelessWidget {
  final MultiSelectController multiSelectDropDown;
  const MultipleSelectionCourseDropDown({super.key, required this.multiSelectDropDown});

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      inputDecoration: BoxDecoration(
        color: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
        borderRadius: BorderRadius.circular(8),
      ),
        fieldBackgroundColor: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
        optionsBackgroundColor: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
        optionTextStyle: const TextStyle(color: Colors.white),
        selectedOptionBackgroundColor: Colors.black,
        controller: multiSelectDropDown,
        onOptionSelected: (val){
          debugPrint(val.toString());
        },
        dropdownBorderRadius: 12.0,
        searchEnabled: true,
        searchBackgroundColor:Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
        dropdownBackgroundColor:Themes.getColors(ColorsValues.LIGHT_GREY_COLOR) ,
        options: getAllCourse());
  }
}

class MultipleSelectionCourseIdDropDown extends StatelessWidget {
  final MultiSelectController multiSelectDropDown;
  const MultipleSelectionCourseIdDropDown({super.key, required this.multiSelectDropDown});

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
        inputDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        fieldBackgroundColor: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
        optionsBackgroundColor: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
        optionTextStyle: const TextStyle(color: Colors.white),
        selectedOptionBackgroundColor: Colors.black,
        controller: multiSelectDropDown,
        onOptionSelected: (val){
          debugPrint(val.toString());
        },
        dropdownBorderRadius: 12.0,
        searchEnabled: true,
        selectionType:SelectionType.single ,
        searchBackgroundColor:Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
        dropdownBackgroundColor:Themes.getColors(ColorsValues.LIGHT_GREY_COLOR) ,
        options: getAllCourseIds());
  }
}
List<ValueItem> getAllCourse(){
  final List<ValueItem> list=[];
  for(int i=0; i<courses.length; i++){
    list.add(ValueItem(label: courses[i]['name']!, value: i));
  }
  return list;
}

List<ValueItem> getAllCourseIds(){
  final List<ValueItem> list=[];
  for(int i=0; i<courses.length; i++){
    list.add(ValueItem(label: courses[i]['code']!.toUpperCase(), value: i));
  }
  return list;
}
List<ValueItem> getValuesFromEnum(){
  final List<ValueItem> list=[];
  for(int i=0; i<SkillsEnum.values.length; i++){
    list.add(ValueItem(label: SkillsEnum.values[i].name, value: i));
  }
  return list;
}
