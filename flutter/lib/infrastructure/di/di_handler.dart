import 'package:get_it/get_it.dart';
import 'package:todo_app_flutter/repository/todo_list/todo_list_repository.dart';
import 'package:todo_app_flutter/repository/todo_list/todo_list_repository_client.dart';

/// Di-контроллер.
class DiHandler {
  /// Регистрирует зависимости в DI.
  static Future<void> configureDi() async {
    final getIt = GetIt.I;

    getIt.registerSingleton<ITodoListRepository>(TodoListRepositoryClient());
  }
}
