import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class ToDoDataBase {
  //reference hive box
  final _mybox = Hive.box('MyBox');

  List toDoList = [];

  // This methods is for if this is the first time user is opening the app
  void createInitialData() {
    // toDoList = [
    //   ['Sleep Early', false],
    //   ['Study for Exam', true],
    //   ['Eat breakfast', false]
    // ];

  }

  //load data from database
  void loadData() {
    toDoList = _mybox.get('TODOLIST');
    print(toDoList);
  }

// update the database
  void updateData() {
    _mybox.put('TODOLIST', toDoList);
  }
}
