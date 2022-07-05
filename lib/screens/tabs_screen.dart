import 'package:flutter/material.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/screens/completed_task_screen.dart';
import 'package:todo/screens/favorite_task_screen.dart';
import 'package:todo/screens/my_drawer.dart';
import 'package:todo/screens/pending_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetail = [
    {'pageName': PendingTasksScreen(), 'title': 'Pending Task'},
    {'pageName': CompleTasksScreen(), 'title': 'Completed Task'},
    {'pageName': FavoriteTasksScreen(), 'title': 'Favorite Task'}
  ];

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetail[_selectedPageIndex]['title']),
        actions: [
          IconButton(
              onPressed: () => _addTask(context), icon: const Icon(Icons.add))
        ],
      ),
      drawer: MyDrawer(),
      body: _pageDetail[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle), label: 'Pending Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done), label: 'completed Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite Tasks'),
        ],
      ),
    );
  }
}
