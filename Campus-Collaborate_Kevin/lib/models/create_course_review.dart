import 'dart:io';
import 'package:campuscollaborate/models/admin.dart';
import 'package:mime/mime.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class CreateCourseReview{
  final String title;
  final String courseName;
  final String description;
  final String userName;
  final String email;
  final String professor;
  CreateCourseReview({
    required this.title,
    required this.courseName,
    required this.description,
    required this.userName,
    required this.email,
    required this.professor,
  });

  Map<String, dynamic> toJson(CreateCourseReview instance) {
    final map = <String, dynamic>{
      'title': instance.title,
      'courseName': instance.courseName,
      'description': instance.description,
      'userName': instance.userName,
      'email':instance.email,
      'professor':instance.professor,
    };
    return map;
  }
}