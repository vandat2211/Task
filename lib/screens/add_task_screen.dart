import 'package:flutter/material.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/services/guid_gen.dart';

import '../blocs/tasks_bloc/tasks_event.dart';
import '../model/task.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);
  TextEditingController titleControler = TextEditingController();
  TextEditingController descriptionControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Add Task',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: TextField(
              autofocus: true,
              controller: titleControler,
              decoration: const InputDecoration(
                  label: Text('Title'), border: OutlineInputBorder()),
            ),
          ),
          TextField(
            autofocus: true,
            controller: descriptionControler,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
                label: Text('Description'), border: OutlineInputBorder()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    var task = Task(
                        title: titleControler.text,
                        id: GUIDGen.generate(),
                        description: descriptionControler.text,
                        date: DateTime.now().toString());
                    context.read<TasksBloc>().add(AddTask(task: task));
                    Navigator.pop(context);
                  },
                  child: const Text('Add'))
            ],
          ),
        ],
      ),
    );
  }
}
