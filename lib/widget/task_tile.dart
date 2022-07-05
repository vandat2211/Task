import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/blocs/tasks_bloc/tasks_event.dart';
import 'package:todo/widget/popup_menu.dart';
import '../blocs/bloc_exports.dart';
import '../model/task.dart';
import '../screens/edit_task_screen.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);
  final Task task;
  void _removeOrDeleteTask(BuildContext context, Task task) {
    task.isDeleted!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(removedTask(task: task));
  }
  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: EditTaskScreen(oldTask: task,),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              task.isFavorite == false
                  ? const Icon(Icons.star_outline)
                  : const Icon(Icons.star),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 18,
                        decoration:
                            task.isDone! ? TextDecoration.lineThrough : null),
                  ),
                  Text(DateFormat()
                      .add_yMMMd()
                      .add_Hms()
                      .format(DateTime.parse(task.date))),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: task.isDone,
              onChanged: task.isDeleted == false
                  ? (value) {
                      context.read<TasksBloc>().add(UpdateTask(task: task));
                    }
                  : null,
            ),
            PopupMenu(
              task: task,
              callbackDelete: () => _removeOrDeleteTask(context, task),
              likeordislike: () => context
                  .read<TasksBloc>()
                  .add(MarkFavoriteOrUnfavoriteTask(task: task)),
              editTask: () {
                _editTask(context);
              },
            )
          ],
        ),
      ],
    );
  }
}
