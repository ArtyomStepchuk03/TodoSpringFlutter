import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app_flutter/feature/home/cubit/home_page_state.dart';
import 'package:todo_app_flutter/feature/home/model/todo_item_dto.dart';
import 'package:todo_app_flutter/repository/todo_list/todo_list_repository.dart';

/// Кубит для управления списком задач
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(InitialHomePageState());

  /// Загружает данные с сервера.
  Future<void> loadTodoListFromServer() async {
    emit(LoadingHomePageState());
    try {
      final List<TodoItemDto>? todoList =
          await GetIt.I.get<ITodoListRepository>().getAll();

      if (todoList == null) {
        emit(ErrorHomePageState('На сервере нет данных по вашему запросу!'));
      }

      emit(SuccessHomePageState(todoList!));
    } catch (e) {
      emit(ErrorHomePageState(
          'Ошибка при загрузке данных! Повторите попытку позже.'));
    }
  }

  /// Создаёт новую задачу и обновляет список.
  Future<void> addNewTask(TodoItemDto todoItem) async {
    assert(state is SuccessHomePageState,
        'Обращение к списку задач при его отсутствии! HomePageCubit.');
    final todoItems = (state as SuccessHomePageState).todoItems;

    emit(LoadingHomePageState());

    try {
      final TodoItemDto? todoItemDto =
          await GetIt.I.get<ITodoListRepository>().addItem(todoItem);

      if (todoItemDto == null) {
        emit(ErrorHomePageState('Ошибка при добавлении элемента!'));
      }

      todoItems.insert(0, todoItemDto!);
      emit(SuccessHomePageState(todoItems));
    } catch (e) {
      emit(ErrorHomePageState(
          'Соединение с сервером нестабильно! Повторите попытку позже.'));
    }
  }

  /// Обновляет задачу в списке.
  Future<void> doneTask(TodoItemDto todoItem) async {
    assert(state is SuccessHomePageState,
        'Обращение к списку задач при его отсутствии! HomePageCubit.');
    final todoItems = (state as SuccessHomePageState).todoItems;

    try {
      todoItem.completed = true;

      final TodoItemDto? updatedTodoItem = await GetIt.I
          .get<ITodoListRepository>()
          .updateItem(todoItem.id!, todoItem);

      if (updatedTodoItem == null) {
        emit(ErrorHomePageState('Ошибка при обновлении элемента!'));
      }

      todoItems[todoItems.indexOf(todoItem)] = todoItem;
    } catch (e) {
      emit(ErrorHomePageState(
          'Соединение с сервером нестабильно! Повторите попытку позже.'));
    }
  }

  /// Удаляет задачу из списка.
  Future<void> deleteTask(TodoItemDto todoItem) async {
    assert(state is SuccessHomePageState,
        'Обращение к списку задач при его отсутствии! HomePageCubit.');
    final todoItems = (state as SuccessHomePageState).todoItems;

    try {
      await GetIt.I.get<ITodoListRepository>().deleteItem(todoItem.id!);

      todoItems.remove(todoItem);
    } catch (e) {
      emit(ErrorHomePageState(
          'Соединение с сервером нестабильно! Повторите попытку позже.'));
    }
  }
}
