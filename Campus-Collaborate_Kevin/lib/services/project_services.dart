import 'dart:io';
import 'package:campuscollaborate/constants/api_end_points.dart';
import 'package:campuscollaborate/constants/http_handler.dart';
import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/locator.dart';
import 'package:campuscollaborate/models/create_project_model.dart';
import 'package:campuscollaborate/models/project.dart';
import 'package:campuscollaborate/services/all_project_providers.dart';
import 'package:campuscollaborate/services/user_services.dart';
import 'package:campuscollaborate/widgets/commonWidgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/dio.dart';
class ProjectServices{
  Future<void> createProject(CreateProjectModel projectModel, BuildContext context, String? imagePath, List<File>? docs)async{
    try{
      final UserServices userServices= UserServices();
      var bodyToBeSent=projectModel.toJson(projectModel);
      final response = await dio.post('$globalApiPoint${projectEndPoint}create',
          data: bodyToBeSent
      );
      final String id=response.data['_id'];
      FirebaseFirestore.instance
          .collection('GroupConversations')
          .doc(id).set({
        'groupId':id,
        'projectName': projectModel.projectName,
      });
     if(imagePath!=null){
       FormData formData = FormData.fromMap({
         "thumbnail": await MultipartFile.fromFile(imagePath, filename: "image.jpg"),
         "id":id
       });
       final thumbnailResponse = await dio.post('$globalApiPoint${projectEndPoint}addThumbnail',
           data: formData
       );
     }
     if(docs!=null&&docs.isNotEmpty)
     {
       final FormData docsFormData = await projectModel.getDocsFormData(docs, id);
       final docsResponse =await dio.post('$globalApiPoint${projectEndPoint}addDocs',
           data: docsFormData
       );
     }

     await userServices.getCurrentUserDetails(context);
     navigationService.pushScreen(Routes.navBarScreen);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(showCommonSnackBar(e.toString()));
    }
  }

  Future<List<Project>> getAllProjects(BuildContext context)async{
    try{
      final response = await dio.get('$globalApiPoint${projectEndPoint}getAllProject');
      final List<Project> fetchedProjects=[];
      for(int i=0;i<response.data.length;i++){
        fetchedProjects.add(Project.fromJson(response.data[i]));
      }
      context.read<AllProjectsProvider>().setFetchedProjects(fetchedProjects);
      return context.read<AllProjectsProvider>().allProjects;
    }catch(e){
      rethrow;
    }
  }

  Future<void> starProject(String id, BuildContext context)async{
    final response = await dio.post('$globalApiPoint${userEndPoint}addStarBy', data: {
      "id":id
    });
    await httpHandler(response, () async{
      await UserServices().getCurrentUserDetails(context);
    }, context);
  }
}