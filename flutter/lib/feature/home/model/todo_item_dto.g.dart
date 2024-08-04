// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoItemDto _$TodoItemDtoFromJson(Map<String, dynamic> json) => TodoItemDto(
      title: json['title'] as String,
      description: json['description'] as String,
      completed: json['completed'] as bool,
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$TodoItemDtoToJson(TodoItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'completed': instance.completed,
    };
