import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_flutter/feature/home/cubit/home_page_cubit.dart';
import 'package:todo_app_flutter/feature/home/model/todo_item_dto.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key, required this.todoItemDto});

  final TodoItemDto todoItemDto;

  @override
  State<StatefulWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.toString()),
      background: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.delete),
          Icon(Icons.delete),
        ],
      ),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        context.read<HomePageCubit>().deleteTask(widget.todoItemDto);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: widget.todoItemDto.completed
                ? Colors.greenAccent
                : Colors.white,
            child: InkWell(
              onTap: () => setState(() => isOpened = !isOpened),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.todoItemDto.title,
                        style: const TextStyle(fontSize: 22),
                      ),
                      if (!widget.todoItemDto.completed) _buildDoneButton(),
                    ],
                  ),
                  if (isOpened) ...[
                    const Gap(10),
                    Text(
                      widget.todoItemDto.description,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black45),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Строит кнопку для отметки задачи как выполненной.
  Widget _buildDoneButton() {
    return IconButton(
      onPressed: () {
        setState(() => widget.todoItemDto.completed = true);
        context.read<HomePageCubit>().doneTask(widget.todoItemDto);
      },
      icon: const Icon(
        Icons.check,
        size: 25,
      ),
    );
  }
}
