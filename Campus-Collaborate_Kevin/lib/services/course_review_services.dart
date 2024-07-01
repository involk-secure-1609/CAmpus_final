import 'dart:io';
import 'package:campuscollaborate/constants/api_end_points.dart';
import 'package:campuscollaborate/constants/http_handler.dart';
import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/locator.dart';
import 'package:campuscollaborate/models/create_course_review.dart';
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
class CourseReviewServices{
  Future<void> createCourseReview(CreateCourseReview courseReview, BuildContext context)async{
    try{
      final UserServices userServices= UserServices();
      var bodyToBeSent=courseReview.toJson(courseReview);
      // print(bodyToBeSent);
      final response = await dio.post('$globalApiPoint${courseReviewEndPoint}create',
          data: bodyToBeSent
      );
      final String id=response.data['_id'];

      print(id);
      await FirebaseFirestore.instance
          .collection('CourseReviewss')
          .doc(id).set({
        'CourseReviewId':id,
        'CourseReviewTitle':courseReview.title,
        'CourseReviewCourseName':courseReview.courseName,
        'CourseReviewContent':courseReview.description,
        'CourseReviewSenderName':courseReview.userName,
        'CourseReviewSenderEmail':courseReview.email,
      });

      await userServices.getCurrentUserDetails(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(showCommonSnackBar(e.toString()));
    }
  }


}