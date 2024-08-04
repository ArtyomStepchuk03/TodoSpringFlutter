import 'package:json_annotation/json_annotation.dart';

part 'todo_item_dto.g.dart';

/// DTO задачи.
@JsonSerializable()
class TodoItemDto {
  int? id;
  final String title;
  final String description;
  bool completed;

  TodoItemDto({
    required this.title,
    required this.description,
    required this.completed,
  });

  factory TodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemDtoToJson(this);
}
