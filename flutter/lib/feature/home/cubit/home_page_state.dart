import 'package:todo_app_flutter/feature/home/model/todo_item_dto.dart';

abstract class HomePageState {}

class InitialHomePageState extends HomePageState {}

class LoadingHomePageState extends HomePageState {}

class SuccessHomePageState extends HomePageState {
  SuccessHomePageState(this.todoItems);

  final List<TodoItemDto> todoItems;
}

class EditingHomePageState extends HomePageState {
  EditingHomePageState(this.todoItems);

  final List<TodoItemDto> todoItems;
}

class ErrorHomePageState extends HomePageState {
  ErrorHomePageState(this.errorMessage);

  final String errorMessage;
}
