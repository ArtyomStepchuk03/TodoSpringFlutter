import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todo_app_flutter/app.dart';
import 'package:todo_app_flutter/feature/home/model/todo_item_dto.dart';
import 'package:todo_app_flutter/repository/todo_list/todo_list_repository.dart';

part 'todo_list_repository_client.g.dart';

@RestApi(baseUrl: 'http://${App.localIp}:8080/api/todos')
abstract class TodoListRepositoryClient implements ITodoListRepository {
  factory TodoListRepositoryClient() => _TodoListRepositoryClient(Dio());

  /// Получает весь список задач.
  @override
  @GET('')
  Future<List<TodoItemDto>>? getAll();

  /// Добавляет в список задачу.
  @override
  @POST('')
  Future<TodoItemDto>? addItem(@Body() TodoItemDto todoItemDto);

  /// Обновляет задачу в списке.
  @override
  @PUT('/{id}')
  Future<TodoItemDto>? updateItem(
      @Path('id') int id, @Body() TodoItemDto todoItem);

  /// Удаляет задачу из списка.
  @override
  @DELETE('/{id}')
  Future<void> deleteItem(@Path('id') int id);
}
