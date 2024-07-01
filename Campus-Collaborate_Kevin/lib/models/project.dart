import 'package:campuscollaborate/models/admin.dart';
import 'package:hive/hive.dart';

part 'project.g.dart';

@HiveType(typeId: 2)
class Project {
  @HiveField(0)
  final String projectName;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final List<dynamic> skills;
  @HiveField(3)
  final List<String>? urls;
  @HiveField(4)
  final String duration;
  @HiveField(5)
  final bool isActive;
  @HiveField(6)
  final String id;
  @HiveField(7)
  final List<Admin>? admin;
  @HiveField(8)
  final List<String>? starBy;
  @HiveField(9)
  final Admin owner;
  @HiveField(10)
  final List<String>? thumbnail;
  @HiveField(11)
  final List<String>? docs;

  Project(
      {required this.projectName,
      required this.description,
      required this.skills,
      required this.urls,
      required this.duration,
      required this.isActive,
      required this.id,
      required this.admin,
      required this.starBy,
      required this.owner,
      required this.docs,
      required this.thumbnail});
  factory Project.fromJson(Map<String, dynamic> json) => Project(
      projectName:
          json['projectName'] == null ? '' : json['projectName'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      skills: json['skills'] == null ? [] : json['skills'] as List<dynamic>,
      urls: json['urls'] == null
          ? []
          : (json['urls'] as List<dynamic>?)?.map((e) => e as String).toList(),
      duration: json['duration'] == null ? '' : json['duration'] as String,
      isActive: json['isActive'] == null ? false : json['isActive'] as bool,
      id: json['_id'] == null ? '' : json['_id'] as String,
      admin: json['admin'] == null
          ? []
          : (json['admin'] as List<dynamic>?)
              ?.map((e) => Admin.fromJson(e as Map<String, dynamic>))
              .toList(),
      starBy: json['starBy'] == null
          ? []
          : (json['starBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      owner: json['owner'] == null
          ? Admin(id: '', name: '')
          : json['owner'] is String
              ? Admin(id: '', name: json['owner'])
              : Admin.fromJson(json['owner']),
      thumbnail: json['thumbnail'] == null
          ? []
          :json['thumbnail'] is String?[json['thumbnail']]: (json['thumbnail'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      docs: json['docs'] == null
          ? []
          : (json['docs'] as List<dynamic>?)?.map((e) => e as String).toList());

  factory Project.fromId(String id) => Project(
      projectName: '',
      description: '',
      skills: [],
      urls: [],
      duration: '',
      isActive: false,
      id: id,
      admin: [],
      starBy: [],
      owner: Admin(id: '', name: ''),
      docs: [],
      thumbnail: []);

  Map<String, dynamic> toJson(Project instance) => <String, dynamic>{
        'projectName': instance.projectName,
        'description': instance.description,
        'skills': instance.skills,
        'urls': instance.urls,
        'duration': instance.duration,
        'isActive': instance.isActive,
        'projectId': instance.id,
        'admin': instance.admin,
        'starBy': instance.starBy,
        'owner': instance.owner,
      };
}
