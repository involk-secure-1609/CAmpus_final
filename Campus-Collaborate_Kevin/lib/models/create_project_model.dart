import 'dart:io';
import 'package:campuscollaborate/models/admin.dart';
import 'package:mime/mime.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class CreateProjectModel{
  final String projectName;
  final String description;
  final List<dynamic> skills;
  final List<String>? urls;
  final String duration;
  final bool isActive;
  final String id;
  final List<Admin>? admin;
  final List<String>? starBy;
  final String owner;
  final File? thumbnail;
  final List<File>? docs;

  CreateProjectModel({
    required this.projectName,
    required this.description,
    required this.skills,
    required this.urls,
    required this.duration,
    required this.isActive,
    required this.id,
    required this.admin,
    required this.starBy,
    required this.owner,
    this.thumbnail,
    this.docs
  });

  Map<String, dynamic> toJson(CreateProjectModel instance) {
    final map= <String, dynamic>{
      'projectName': instance.projectName,
      'description': instance.description,
      'skills': instance.skills,
      'urls': instance.urls,
      'duration': instance.duration,
      'isActive': instance.isActive,
      '_id': instance.id,
      'admin': instance.admin==null?null:instance.admin!.map((e) => e.toJson(e)).toList(),
      'starBy': instance.starBy,
      'owner': instance.owner,
      'thumbnail': null
    };
    return map;
  }
  Future<FormData> getDocsFormData(List<File> docs, String id) async {
    var formData = FormData();
    for (var file in docs) {
      formData.files.addAll([
        MapEntry("docs", await MultipartFile.fromFile(file.path)),
      ]);
    }
    formData.fields.add(MapEntry("id",id));
    return formData;
  }
}