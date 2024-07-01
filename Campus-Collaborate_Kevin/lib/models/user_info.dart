import 'package:campuscollaborate/models/project.dart';
import 'package:hive/hive.dart';

part 'user_info.g.dart';

@HiveType(typeId: 1)
class UserInfo {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String rollNumber;
  @HiveField(2)
  final List<dynamic> skills;
  @HiveField(3)
  final List<String> courses;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String? url;
  @HiveField(6)
  final String program;
  @HiveField(7)
  List<Project>? projects;
  @HiveField(8)
  List<Project>? starBy;

  UserInfo(
      {required this.name,
      required this.rollNumber,
      required this.skills,
      required this.courses,
      required this.email,
      required this.url,
      required this.program,
      required this.projects,
      this.starBy
      });
  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        name: json['name'] as String,
        rollNumber: json['rollNumber'].toString(),
        skills: json['skills'] as List<dynamic>,
        courses:
            (json['courses'] as List<dynamic>).map((e) => e as String).toList(),
        email: json['email'] as String,
        url: json['url'] as String?,
        program: json['program'] as String,
        projects: (json['projects'] as List<dynamic>?)
            ?.map((e) => e is String?Project.fromId(e):Project.fromJson(e as Map<String, dynamic>))
            .toList(),
        starBy: (json['starBy'] as List<dynamic>?)
            ?.map((e) => e is String?Project.fromId(e):Project.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson(UserInfo instance) => <String, dynamic>{
        'name': instance.name,
        'rollNumber': instance.rollNumber,
        'skills': instance.skills,
        'courses': instance.courses,
        'email': instance.email,
        'url': instance.url,
        'program': instance.program,
        'projects': instance.projects,
      };
  void addProjects(List<Project> projectList){
    projects=projectList;
  }
}
