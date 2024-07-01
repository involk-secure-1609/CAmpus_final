import 'package:campuscollaborate/chats/groupmessages.dart';
import 'package:campuscollaborate/constants/themes.dart';
import 'package:campuscollaborate/models/project.dart';
import 'package:campuscollaborate/services/project_services.dart';
import 'package:campuscollaborate/services/user_provider.dart';
import 'package:campuscollaborate/widgets/commonWidgets/app_bar.dart';
import 'package:campuscollaborate/widgets/commonWidgets/contributors_container.dart';
import 'package:campuscollaborate/widgets/commonWidgets/skills_container.dart';
import 'package:campuscollaborate/widgets/commonWidgets/custom_floating_action_button.dart';
import 'package:campuscollaborate/widgets/commonWidgets/snack_bar.dart';
import 'package:campuscollaborate/widgets/image_collage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:provider/provider.dart';

import '../models/user_info.dart';
import '../widgets/createProjectScreen/docs_images.dart';

class ProjectScreen extends StatelessWidget {
  final Project project;
  const ProjectScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButton: Consumer<UserProvider>(
            builder: (context, service, child){
              return CustomFloatingActionButton(
              onPressed: () async{
                if(context.read<UserProvider>().userInfo.starBy!=null&&ifStarByProjectIsContained(context.read<UserProvider>().userInfo.starBy!, project)){
                  return;
                }else{
                  await ProjectServices().starProject(project.id, context);
                }
              },
              icon:context.read<UserProvider>().userInfo.starBy==null||!ifStarByProjectIsContained(context.read<UserProvider>().userInfo.starBy!, project)?Image.asset('assets/star.png'):Image.asset('assets/filled_star.png')
          );
        },
      ),
      appBar: customAppBar(project.projectName),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              project.thumbnail == null || project.thumbnail!.isEmpty
                  ? const SizedBox(
                height: 0,
              ):CustomImageCollage(imagesLink: project.thumbnail!),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.projectName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Time Taken: ${project.duration}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      final String chatId= project.id;
                      final UserInfo myUserInfo=context.read<UserProvider>().userInfo;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroupMessageScreen(groupId: chatId, myInfo: myUserInfo, team: project,)
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color:
                              Themes.getColors(ColorsValues.LIGHT_GREY_COLOR),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Image.asset(
                        'assets/chat_bubble.png',
                        height: 25,
                        width: 25,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SkillListWithoutButton(skillsList: project.skills),
              const SizedBox(height: 10,),
              project.admin == null || project.admin!.isEmpty
                  ? const SizedBox(
                      height: 0,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contributors',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10,),
                        ContributorListView(contributorsList: project.admin!)
                      ],
                    ),
              const SizedBox(
                height: 10,
              ),
              project.docs==null||project.docs!.isEmpty?const SizedBox(height: 0,width: 0,):Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Documents',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10,),
                  Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.docs!.map((docs) {
                        return GestureDetector(
                          onTap: ()async{
                            FileDownloader.downloadFile(
                                url: docs,
                                onProgress: (string, progress){

                                },
                                onDownloadCompleted: (String path) {
                                  ScaffoldMessenger.of(context).showSnackBar(showCommonSnackBar('File downloaded to path: $path'));
                                },
                                onDownloadError: (String error) {
                                  ScaffoldMessenger.of(context).showSnackBar(showCommonSnackBar('Download Error: $error'));
                                });
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/docs.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                    Expanded(
                                      child: Text(
                                        docs,
                                        style: const TextStyle(
                                            fontSize:  13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        );
                      }).toList())
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                project.description,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

bool ifStarByProjectIsContained(List<Project> list, Project project){
  for(int i=0; i<list.length; i++){
    if(list[i].id==project.id){
      return true;
    }
  }
  return false;
}

