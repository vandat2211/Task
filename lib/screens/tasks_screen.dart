import 'package:flutter/material.dart';
import 'package:todo/blocs/bloc/tasks_event.dart';
import 'package:todo/blocs/bloc/tasks_state.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/model/task.dart';
import 'package:todo/widget/tasks_list.dart';

import 'add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({Key? key}) : super(key: key);

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      List<Task> tasklist = state.allTasks;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Tasks App'),
          actions: [IconButton(onPressed: ()=>_addTask(context), icon: const Icon(Icons.add))],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Chip(
                label: Text(
                  'Tasks:',
                ),
              ),
            ),
            TasksList(
              tasklist: tasklist,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addTask(context),
          tooltip: 'Add Task',
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
