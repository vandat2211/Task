import 'package:flutter/material.dart';
import 'package:todo/blocs/bloc/tasks_event.dart';
import 'package:todo/blocs/bloc_exports.dart';

import '../model/task.dart';
class TasksList extends StatelessWidget {
  const TasksList({Key? key, required this.tasklist}) : super(key: key);
  final List<Task> tasklist;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(itemCount: tasklist.length,itemBuilder: (context,index){
        var task=tasklist[index];
        return ListTile(
          title: Text(task.title),
          trailing: Checkbox(value: task.isDone,onChanged: (value){
            context.read<TasksBloc>().add(UpdateTask(task: task));
          },),
          onLongPress: ()=>context.read<TasksBloc>().add(DeleteTask(task: task)),
        );
      }),
    );
  }
}
