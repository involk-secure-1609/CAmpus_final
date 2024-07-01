import 'package:campuscollaborate/constants/all_courses.dart';
import 'package:campuscollaborate/constants/skills.dart';
import 'package:flutter/material.dart';

class SkillContainer extends StatelessWidget {
  final dynamic skill;
  final double? fontSize;
  final bool? isCourse;
  const SkillContainer({super.key, required this.skill, this.fontSize, this.isCourse});

  @override
  Widget build(BuildContext context) {
    final List<int> skillInt=[0];
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isParsable(skill, skillInt)
            ? SkillsComponents.getSkillColor(SkillsEnum.values[skillInt[0]])
            : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Text(
        isParsable(skill, skillInt)?SkillsEnum.values[skillInt[0]].name : skill.toString(),
        style: TextStyle(
            fontSize: fontSize ?? 13,
            color: Colors.black,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class SkillsListView extends StatelessWidget {
  final List<dynamic> skillsList;
  const SkillsListView({super.key, required this.skillsList});

  @override
  Widget build(BuildContext context) {
    if (skillsList.length <= 5) {
      return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skillsList.map((skill) {
            return SkillContainer(skill: skill);
          }).toList());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skillsList.take(4).map((skill) {
            return SkillContainer(skill: skill);
          }).toList(),
        ),
        const SizedBox(height: 5,),
        ElevatedButton(
          onPressed: () {
            // Handle the onPressed event of the ElevatedButton
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          ),
          child: Text(
            '+${skillsList.length - 4} More',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class SkillListWithoutButton extends StatelessWidget {
  final List<dynamic> skillsList;
  const SkillListWithoutButton({super.key, required this.skillsList});

  @override
  Widget build(BuildContext context) {
    return  Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skillsList.map((skill) {
        return SkillContainer(skill: skill);
      }).toList(),
    );
  }
}

bool isParsable(String source, List<int> tobeChangedValue){
  try{
    int parsedInt= int.parse(source);
    tobeChangedValue[0]=parsedInt;
    return true;
  }catch(e){
    return false;
  }
}

class CourseContainer extends StatelessWidget {
  final String index;
  const CourseContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final List<int> listForChanging=[0];
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Text(isParsable(index,listForChanging)?
        courses[listForChanging[0]]['name'].toString():'Invalid Course',
        style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class CourseContainerListView extends StatelessWidget {
  final List<String> coursesList;
  const CourseContainerListView({super.key, required this.coursesList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: coursesList.map((index) {
        return CourseContainer(index: index);
      }).toList(),
    );
  }
}





