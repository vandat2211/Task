import 'package:flutter/material.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/blocs/tasks_bloc/tasks_state.dart';
import 'package:todo/screens/my_drawer.dart';
import 'package:todo/widget/tasks_list.dart';
class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);
static const id='recycle_bin_screen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context,state) {
        return
        Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin '),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.add))
            ],
          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Center(
                child: Chip(
                  label: Text(
                    'task : ${state.removedTask.length}',
                  ),
                ),
              ),
              TasksList(
                tasklist:state.removedTask,
              )
            ],
          ),

        );
      });
  }
}
