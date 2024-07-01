import 'package:campuscollaborate/widgets/commonWidgets/app_bar.dart';
import 'package:flutter/material.dart';
import '../constants/routing_constants.dart';
import '../locator.dart';
import '../models/project.dart';
import '../widgets/commonWidgets/project_container.dart';

class ProjectListScreen extends StatelessWidget {
  final List<Project>? project;
  const ProjectListScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: customAppBar('Projects'),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
        child: project == null || project!.isEmpty
            ? const Center(
          child: Text('No Projects to Show!'),
        )
            : Column(
              children: [
                Expanded(
                          child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: project!.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                      navigationService.pushScreen(Routes.projectScreen, arguments:project![index]);
                    },
                    child: ProjectContainer(
                        project: project![index]),
                  )),
                        ),
              ],
            ),
      ),
    ));
  }
}

class SavedProjectListScreen extends StatelessWidget {
  final List<Project>? project;
  const SavedProjectListScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: customAppBar('Saved Projects'),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
        child: project == null || project!.isEmpty
            ? const Center(
          child: Text('No Projects to Show!'),
        )
            : Column(
          children: [
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: project!.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                      navigationService.pushScreen(Routes.projectScreen, arguments:project![index]);
                    },
                    child: ProjectContainer(
                        project: project![index]),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}

