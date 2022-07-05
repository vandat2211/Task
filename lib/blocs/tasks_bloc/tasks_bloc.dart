import 'package:todo/blocs/bloc_exports.dart';
import 'package:todo/blocs/tasks_bloc/tasks_event.dart';
import 'package:todo/blocs/tasks_bloc/tasks_state.dart';
import 'package:todo/model/task.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<removedTask>(_onRemovedTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTask: state.removedTask,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: true))
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false))
          };
    emit(
        TasksState(pendingTasks: pendingTasks, removedTask: state.removedTask,completedTasks: completedTasks,favoriteTasks: state.favoriteTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTask: List.from(state.removedTask)..remove(event.task)));
  }

  void _onRemovedTask(removedTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTask: List.from(state.removedTask)
          ..add(event.task.copyWith(isDeleted: true))));
  }
 void _onMarkFavoriteOrUnfavoriteTask(MarkFavoriteOrUnfavoriteTask event,Emitter<TasksState> emit){
    final state = this.state;
    List<Task> pendingTasks=state.pendingTasks;
    List<Task> completedTasks=state.completedTasks;
    List<Task> favoriteTasks=state.favoriteTasks;
    if(event.task.isDone==false){
      if(event.task.isFavorite==false){
        var taskIndex=pendingTasks.indexOf(event.task);
        pendingTasks=List.from(pendingTasks)
        ..remove(event.task)
        ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      }else{
        var taskIndex=pendingTasks.indexOf(event.task);
        pendingTasks=List.from(pendingTasks)
        ..remove(event.task)
        ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }else{
      if(event.task.isFavorite==false){
        var taskIndex=completedTasks.indexOf(event.task);
        completedTasks=List.from(completedTasks)
        ..remove(event.task)
        ..insert(taskIndex,event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      }
      else{
        var taskIndex=completedTasks.indexOf(event.task);
        completedTasks=List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex,event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }
    emit(TasksState(pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,removedTask: state.removedTask));
 }
 void _onEditTask(EditTask event,Emitter<TasksState> emit){
   final state = this.state;
   List<Task> favoriteTasks=state.favoriteTasks;
   if(event.oldTask.isFavorite==true){
     favoriteTasks
     ..remove(event.oldTask)
         ..insert(0, event.newTask);
   }
   emit(
     TasksState(pendingTasks: List.from(state.pendingTasks)
         ..remove(event.oldTask)
         ..insert(0, event.newTask),
         completedTasks: state.completedTasks..remove(event.oldTask),
     favoriteTasks: favoriteTasks,
       removedTask: state.removedTask,
     )
   );
 }
  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
