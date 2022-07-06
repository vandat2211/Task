import 'package:flutter/material.dart';

import '../model/task.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu(
      {Key? key,
      required this.callbackDelete,
      required this.task,
      required this.likeordislike, required this.editTask, required this.restoreTask})
      : super(key: key);
  final VoidCallback callbackDelete;
  final VoidCallback likeordislike;
  final VoidCallback editTask;
  final VoidCallback restoreTask;
  final Task task;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? ((context) => [
                PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: editTask,
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit')),
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: likeordislike,
                      icon: task.isFavorite == false
                          ? const Icon(Icons.bookmark_add_outlined)
                          : const Icon(Icons.bookmark_remove),
                      label: task.isFavorite == false
                          ? const Text('Add to Favorite')
                          : const Text('Remove from Favorite')),
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: callbackDelete,
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete')),
                ),
              ])
          : (context) => [
                PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: restoreTask,
                      icon: const Icon(Icons.restore_from_trash),
                      label: const Text('Restore')),
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: callbackDelete,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Delete Forever')),
                ),
              ],
    );
  }
}
