// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_remainder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoRemainderAdapter extends TypeAdapter<TodoRemainder> {
  @override
  final typeId = 0;

  @override
  TodoRemainder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoRemainder(
      todoDescription: fields[0] as String,
      hour: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TodoRemainder obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.todoDescription)
      ..writeByte(1)
      ..write(obj.hour);
  }
}
