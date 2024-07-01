import 'dart:io';
import 'package:campuscollaborate/models/admin.dart';
import 'package:mime/mime.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class CreateSynergy{
  final String title;
  final String description;
  final String userName;
  final String email;
  CreateSynergy({
    required this.title,
    required this.description,
    required this.userName,
    required this.email,
  });

  Map<String, dynamic> toJson(CreateSynergy instance) {
    final map = <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'userName': instance.userName,
      'email':instance.email,
    };
    return map;
  }
}