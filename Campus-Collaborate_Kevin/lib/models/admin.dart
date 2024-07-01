import 'package:hive/hive.dart';
part 'admin.g.dart';

@HiveType(typeId: 3)
class Admin {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? url;

  Admin({required this.id, required this.name, this.url});

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
      id: json['id']==null?'':json['id'] as String,
      name: json['name']==null?'':json['name'] as String,
      url: json['url']==null?'':json['url'] as String );

  factory Admin.fromJsonId(Map<String, dynamic> json)=>Admin(
      id: json['_id']==null?'':json['_id'] as String,
      name: json['name']==null?'':json['name'] as String,
      url: json['url']==null?'':json['url'] as String );

  Map<String, dynamic> toJson(Admin admin) =>
      <String, dynamic>{"id": admin.id, "name": admin.name, "url": admin.url};
}
