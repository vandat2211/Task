import 'package:flutter/material.dart';
import 'package:todo/blocs/bloc/tasks_state.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/screens/recycle_bin.dart';
import 'package:todo/screens/tasks_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: Colors.grey,
            child: Text(
              'Task Drawer',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(TasksScreen.id),
              child: ListTile(
                leading: const Icon(Icons.folder_special),
                title: const Text('My Task'),
                trailing: Text('${state.allTasks.length}'),
              ),
            );
          }),
          const Divider(),
          BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(RecycleBin.id),
              child:  ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Bin'),
                trailing: Text('${state.removedTask.length}'),
              ),
            );
          })
        ],
      )),
    );
  }
}
