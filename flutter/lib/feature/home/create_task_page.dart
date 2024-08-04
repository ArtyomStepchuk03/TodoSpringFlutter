import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_flutter/feature/home/cubit/home_page_cubit.dart';
import 'package:todo_app_flutter/feature/home/model/todo_item_dto.dart';

/// Страница с формой для создания новой задачи.
class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> _isTitleFiled = ValueNotifier<bool>(false);

    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();

    _titleController.addListener(
        () => _isTitleFiled.value = _titleController.text.isNotEmpty);

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('New task'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                maxLines: 1,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const Gap(10),
              TextField(
                minLines: 6,
                maxLines: 6,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const Gap(10),
              _buildAddTaskButton(
                  _isTitleFiled, _titleController, _descriptionController),
            ],
          ),
        ),
      ),
    );
  }

  /// Строит кнопку для добавления новой задачи.
  Widget _buildAddTaskButton(
      ValueNotifier<bool> _isTitleFiled,
      TextEditingController _titleController,
      TextEditingController _descriptionController) {
    return ValueListenableBuilder<bool>(
        valueListenable: _isTitleFiled,
        builder: (context, isEnabled, child) {
          return ElevatedButton(
            style: isEnabled
                ? ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.blue))
                : ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.white12)),
            onPressed: () => isEnabled
                ? _onAddButtonPress(
                    context, _titleController.text, _descriptionController.text)
                : null,
            child: const Text(
              'Добавить',
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }

  /// Обрабатывает нажатие на кнопку добавления новой задачи.
  void _onAddButtonPress(BuildContext context, title, description) {
    context.read<HomePageCubit>().addNewTask(
          TodoItemDto(title: title, description: description, completed: false),
        );
    Navigator.of(context).pop();
  }
}
