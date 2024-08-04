import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/common/widget/loading_indicator_widget.dart';
import 'package:todo_app_flutter/feature/home/create_task_page.dart';
import 'package:todo_app_flutter/feature/home/cubit/home_page_cubit.dart';
import 'package:todo_app_flutter/feature/home/cubit/home_page_state.dart';
import 'package:todo_app_flutter/feature/home/model/todo_item_dto.dart';
import 'package:todo_app_flutter/feature/home/widget/task_widget.dart';

/// Страница со списком задач.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SafeArea(
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (_, state) {
            if (state is InitialHomePageState) {
              context.read<HomePageCubit>().loadTodoListFromServer();
            }

            return RefreshIndicator(
              onRefresh: () =>
                  context.read<HomePageCubit>().loadTodoListFromServer(),
              child: _buildContent(context, state),
            );
          },
        ),
      ),
    );
  }

  /// Строит наполнение страницы.
  Widget _buildContent(BuildContext context, HomePageState state) {
    if (state is SuccessHomePageState) {
      return Column(
        children: [
          Expanded(child: _buildTodoList(state)),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<HomePageCubit>(context),
                    child: const CreateTaskPage(),
                  ),
                ),
              ),
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add),
            ),
          )
        ],
      );
    }
    if (state is LoadingHomePageState) {
      return const LoadingIndicatorWidget();
    }

    if (state is ErrorHomePageState) {
      return _buildErrorWidget(state);
    }

    return Container();
  }

  /// Строит список задач.
  Widget _buildTodoList(SuccessHomePageState state) {
    List<TodoItemDto> todoList = state.todoItems;

    todoList.sort((first, second) =>
        first.completed == second.completed ? 0 : (first.completed ? 1 : -1));

    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: todoList.length,
      itemBuilder: (context, index) => TaskWidget(
        todoItemDto: todoList[index],
      ),
    );
  }

  /// Строит виджет с сообщением об ошибке.
  Widget _buildErrorWidget(ErrorHomePageState errorState) {
    return Center(
      child: Text(
        errorState.errorMessage,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontSize: 20),
      ),
    );
  }
}
