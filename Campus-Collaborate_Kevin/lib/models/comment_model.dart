import 'dart:io';
import 'package:campuscollaborate/models/admin.dart';
import 'package:mime/mime.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class CourseReviewComment{
  final String id;
  final String course;
  final String review;
  final String user;
  final String title;
  final String email;
  CourseReviewComment({
    required this.id,
    required this.course,
    required this.review,
    required this.email,
    required this.title,
    required this.user,
  });
}