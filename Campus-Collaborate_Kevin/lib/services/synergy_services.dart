import 'dart:io';
import 'package:campuscollaborate/constants/api_end_points.dart';
import 'package:campuscollaborate/constants/http_handler.dart';
import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/locator.dart';
import 'package:campuscollaborate/models/create_course_review.dart';
import 'package:campuscollaborate/models/create_project_model.dart';
import 'package:campuscollaborate/models/create_synergy.dart';
import 'package:campuscollaborate/models/project.dart';
import 'package:campuscollaborate/services/all_project_providers.dart';
import 'package:campuscollaborate/services/user_services.dart';
import 'package:campuscollaborate/widgets/commonWidgets/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/dio.dart';
class SynergyServices{
  Future<void> createSynergy(CreateSynergy synergy, BuildContext context)async{
    try{
      final UserServices userServices= UserServices();
      var bodyToBeSent=synergy.toJson(synergy);
      // print(bodyToBeSent);
      final response = await dio.post('$globalApiPoint${synergyEndPoint}create',
          data: bodyToBeSent
      );
      final String id=response.data['_id'];

      print(id);
      await FirebaseFirestore.instance
          .collection('Synergy')
          .doc(id).set({
        'SynergyId':id,
        'SynergyTitle':synergy.title,
        'SynergyDescription':synergy.description,
        'SynergySenderName':synergy.userName,
        'SynergySenderEmail':synergy.email,
      });

      await userServices.getCurrentUserDetails(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(showCommonSnackBar(e.toString()));
    }
  }


}