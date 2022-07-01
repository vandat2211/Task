import 'package:equatable/equatable.dart';

import '../../model/task.dart';

class TasksState extends Equatable{
  final List<Task> allTasks;
  final List<Task> removedTask;
  const TasksState({this.allTasks=const<Task>[],this.removedTask=const<Task>[]});

  @override
  List<Object?> get props => [allTasks,removedTask];
  Map<String,dynamic> toMap(){
    return{
      'allTasks':allTasks.map((x) => x.toMap()).toList(),
      'removedTask':removedTask.map((x) => x.toMap()).toList(),
    };
  }
  factory TasksState.fromMap(Map<String,dynamic> map){
    return TasksState(
      allTasks: List<Task>.from(map['allTasks']?.map((x)=> Task.fromMap(x))),
        removedTask: List<Task>.from(map['removedTask']?.map((x)=> Task.fromMap(x)))
    );
  }
}