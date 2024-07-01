// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoAdapter extends TypeAdapter<UserInfo> {
  @override
  final int typeId = 1;

  @override
  UserInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfo(
      name: fields[0] as String,
      rollNumber: fields[1] as String,
      skills: (fields[2] as List).cast<dynamic>(),
      courses: (fields[3] as List).cast<String>(),
      email: fields[4] as String,
      url: fields[5] as String?,
      program: fields[6] as String,
      projects: (fields[7] as List?)?.cast<Project>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserInfo obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.rollNumber)
      ..writeByte(2)
      ..write(obj.skills)
      ..writeByte(3)
      ..write(obj.courses)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.program)
      ..writeByte(7)
      ..write(obj.projects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
