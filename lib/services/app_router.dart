import 'package:flutter/material.dart';
import 'package:todo/screens/recycle_bin.dart';
import 'package:todo/screens/tabs_screen.dart';
import 'package:todo/screens/pending_screen.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_)=>const RecycleBin());
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_)=>  TabsScreen());
      default:
        return null;
    }
  }
}