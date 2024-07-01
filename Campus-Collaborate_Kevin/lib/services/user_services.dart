import 'dart:convert';

import 'package:campuscollaborate/constants/api_end_points.dart';
import 'package:campuscollaborate/constants/dio.dart';
import 'package:campuscollaborate/constants/routing_constants.dart';
import 'package:campuscollaborate/hive_boxes.dart';
import 'package:campuscollaborate/locator.dart';
import 'package:campuscollaborate/models/admin.dart';
import 'package:campuscollaborate/services/docs_and_images.dart';
import 'package:campuscollaborate/services/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../models/user_info.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
class UserServices {

  Future<UserInfo> getCurrentUserDetails(BuildContext context) async {
    try {
      final response = await dio.get('$globalApiPoint${userEndPoint}userById');
      print(response.data['starBy']);
      final UserInfo userInfo = UserInfo.fromJson(response.data);
      context.read<UserProvider>().setUser(userInfo);
      return context
          .read<UserProvider>()
          .userInfo;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateSkills(BuildContext context, List<String> skills) async {
    try {
      final response = await dio.post('$globalApiPoint${userEndPoint}addSkills',
        data: {
          "skills": skills
        },
      );
      final UserInfo userInfo = UserInfo.fromJson(response.data);
      context.read<UserProvider>().setUser(userInfo);
      print("hi");
      print(response.data);
    } catch (e) {
      print("__________________");
      print(e.toString());
      rethrow;
    }
  }
  Future<void> updateCourses(BuildContext context,List<String> courses) async {
    try {
      final response = await dio.post('$globalApiPoint${userEndPoint}addCourses',
        data: {
          "courses": courses
        },
      );
      final UserInfo userInfo = UserInfo.fromJson(response.data);
      context.read<UserProvider>().setUser(userInfo);
      print("hi");
      print(response.data);
    } catch (e) {
      print("__________________");
      print(e.toString());
      rethrow;
    }
  }
  Future<void> updateDp(String imagePath) async {
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(imagePath, filename: "image.png"),
    });
    final response = await dio.post('$globalApiPoint${userEndPoint}changeDp',
      data: formData,
    );
    print("Success??");
    print(response.data);
  }

  Future<List<Admin>> getSearchedUsers(String query)async{
    final response = await dio.get('$globalApiPoint${userEndPoint}searchUser/$query');
    print(response.data);
    final List<Admin> searchedList=[];
    if(response.data is Map<String, dynamic>){
      searchedList.add(Admin.fromJsonId(response.data));
      return searchedList;
    }
    else if(response.data is List){
      for(int i=0; i<response.data.length; i++){
        searchedList.add(Admin.fromJsonId(response.data[i]));
      }
      return searchedList;
    }
    return searchedList;
  }
  Future<UserInfo> getUserById(String id)async{
    try{
      final response = await dio.get('$globalApiPoint${userEndPoint}userById',
          data: {
            "id":id
          }
      );
      final UserInfo userInfo= UserInfo.fromJson(response.data);
      return userInfo;
    }catch(e){
      rethrow;
    }
  }

  Future<void> logOut()async{
    await accessTokenBox.delete(accessTokenKey);
    await loggedInBox.delete(loggedInKey);
    token='';
    navigationService.removeAllAndPush(Routes.loginScreen, Routes.profileScreen);
  }
}