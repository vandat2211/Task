import 'package:flutter/material.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/blocs/switch_bloc/switch_bloc.dart';
import 'package:todo/blocs/switch_bloc/switch_event.dart';
import 'package:todo/blocs/switch_bloc/switch_state.dart';
import 'package:todo/blocs/tasks_bloc/tasks_state.dart';
import 'package:todo/screens/recycle_bin.dart';
import 'package:todo/screens/tabs_screen.dart';
import 'package:todo/screens/pending_screen.dart';

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
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed(TabsScreen.id),
              child: ListTile(
                leading: const Icon(Icons.folder_special),
                title: const Text('My Task'),
                trailing: Text('${state.pendingTasks.length} | ${state.completedTasks.length}'),
              ),
            );
          }),
          const Divider(),
          BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
            return GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed(RecycleBin.id),
              child: ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Bin'),
                trailing: Text('${state.removedTask.length}'),
              ),
            );
          }),
          BlocBuilder<SwitchBloc, SwitchState>(builder: (context, state) {
            return Switch(
                value: state.switchValue,
                onChanged: (newValue) {
                newValue? context.read<SwitchBloc>().add(SwitchOnEvent())
                    :context.read<SwitchBloc>().add(SwitchOffEvent());
                });
          })
        ],
      )),
    );
  }
}
