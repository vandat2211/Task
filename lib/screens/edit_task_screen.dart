import 'package:flutter/material.dart';
import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/services/guid_gen.dart';

import '../blocs/tasks_bloc/tasks_event.dart';
import '../model/task.dart';

class EditTaskScreen extends StatelessWidget {
  EditTaskScreen({Key? key, required this.oldTask}) : super(key: key);
  final Task oldTask;
  @override
  Widget build(BuildContext context) {
    TextEditingController titleControler = TextEditingController(text: oldTask.title);
    TextEditingController descriptionControler = TextEditingController(text: oldTask.description);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Edit Task',
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
                    var editTask = Task(
                        title: titleControler.text,
                        id: oldTask.id,
                        isDone: false,
                        isFavorite: oldTask.isFavorite,
                        description: descriptionControler.text,
                        date: DateTime.now().toString());
                    context.read<TasksBloc>().add(EditTask(oldTask: oldTask,newTask: editTask));
                    Navigator.pop(context);
                  },
                  child: const Text('Save'))
            ],
          ),
        ],
      ),
    );
  }
}
