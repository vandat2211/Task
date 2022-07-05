import 'package:flutter/material.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/blocs/tasks_bloc/tasks_state.dart';
import 'package:todo/model/task.dart';
import 'package:todo/widget/tasks_list.dart';


class CompleTasksScreen extends StatelessWidget {
  CompleTasksScreen({Key? key}) : super(key: key);
  static const id="task_screen";


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      List<Task> tasklist = state.completedTasks;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Chip(
              label: Text(
                'tasks : ${tasklist.length}',
              ),
            ),
          ),
          TasksList(
            tasklist: tasklist,
          )
        ],
      );

    });
  }
}
