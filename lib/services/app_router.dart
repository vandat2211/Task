import 'package:flutter/material.dart';
import 'package:todo/screens/recycle_bin.dart';
import 'package:todo/screens/tasks_screen.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_)=>const RecycleBin());
      case TasksScreen.id:
        return MaterialPageRoute(builder: (_)=> TasksScreen());
      default:
        return null;
    }
  }
}