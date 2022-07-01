import 'package:flutter/material.dart';
import 'package:todo/blocs/bloc/tasks_event.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/widget/task_tile.dart';

import '../model/task.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key, required this.tasklist}) : super(key: key);
  final List<Task> tasklist;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: tasklist.length,
          itemBuilder: (context, index) {
            var task = tasklist[index];
            return TaskTile(task:task);
          }),
    );
  }
}
