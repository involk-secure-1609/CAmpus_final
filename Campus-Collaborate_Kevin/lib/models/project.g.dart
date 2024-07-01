// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectAdapter extends TypeAdapter<Project> {
  @override
  final int typeId = 2;

  @override
  Project read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Project(
      projectName: fields[0] as String,
      description: fields[1] as String,
      skills: (fields[2] as List).cast<dynamic>(),
      urls: (fields[3] as List?)?.cast<String>(),
      duration: fields[4] as String,
      isActive: fields[5] as bool,
      id: fields[6] as String,
      admin: (fields[7] as List?)?.cast<Admin>(),
      starBy: (fields[8] as List?)?.cast<String>(),
      owner: fields[9] as Admin,
      docs: (fields[11] as List?)?.cast<String>(),
      thumbnail: (fields[10] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Project obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.projectName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.skills)
      ..writeByte(3)
      ..write(obj.urls)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.isActive)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.admin)
      ..writeByte(8)
      ..write(obj.starBy)
      ..writeByte(9)
      ..write(obj.owner)
      ..writeByte(10)
      ..write(obj.thumbnail)
      ..writeByte(11)
      ..write(obj.docs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
