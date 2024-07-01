import 'package:campuscollaborate/models/project.dart';
import 'package:campuscollaborate/widgets/commonWidgets/contributors_container.dart';
import 'package:campuscollaborate/widgets/commonWidgets/skills_container.dart';
import 'package:campuscollaborate/widgets/commonWidgets/user_circular_avtar_list.dart';
import 'package:flutter/material.dart';

import '../../constants/themes.dart';

class ProjectContainer extends StatelessWidget {
  final Project project;
  const ProjectContainer({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return project.thumbnail == null || project.thumbnail!.isEmpty
        ? ProjectContainerWithoutImage(project: project)
        : Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                        child: Image.network(
                          project.thumbnail![0],
                          height: 130,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )),
                  ProjectContainerWithoutImage(project: project)
                ],
              ),
            ),
            const SizedBox(height: 20,)
          ],
        );
  }
}

class ProjectContainerWithoutImage extends StatelessWidget {
  final Project project;
  const ProjectContainerWithoutImage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    project.projectName,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    project.admin == null ? 'Individual Project' : 'Group Project',
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    project.duration,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  project.admin == null
                      ? ContributorContainer(
                          contributor: project.owner,
                          fontSize: 10,
                        )
                      : UserCircularAvatars(admins: project.admin!)
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                project.description,
                style: const TextStyle(
                    fontSize: 10, color: Colors.white, fontWeight: FontWeight.w400),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10,
              ),
              SkillsListView(skillsList: project.skills)
            ],
          ),
        ),
        const SizedBox(height: 20,)
      ],
    );
  }
}
