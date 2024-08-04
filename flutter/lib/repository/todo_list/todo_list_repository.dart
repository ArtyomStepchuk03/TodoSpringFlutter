import 'package:todo_app_flutter/feature/home/model/todo_item_dto.dart';

/// Репозиторий для взаимодействия со списком задач.
abstract class ITodoListRepository {
  /// Получает весь список задач.
  Future<List<TodoItemDto>>? getAll();

  /// Добавляет в список задачу.
  Future<TodoItemDto>? addItem(TodoItemDto todoItemDto);

  /// Обновляет задачу в списке.
  Future<TodoItemDto>? updateItem(int id, TodoItemDto todoItem);

  /// Удаляет задачу из списка.
  Future<void> deleteItem(int id);
}
