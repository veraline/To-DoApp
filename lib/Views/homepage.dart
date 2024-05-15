import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todoapp/Controllers/dialong_box.dart';
import 'package:todoapp/Controllers/todo_tile.dart';
import 'package:get/get.dart';
import 'package:todoapp/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ToDoDataBase db = ToDoDataBase();
  final _controller = TextEditingController();

  DateTime today = DateTime.now();
  //reference the box
  final _mybox = Hive.box('MyBox');

  @override
  void initState() {
    //if this is the first time opening app, the default data to be displayed.
    if (_mybox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // The exixting data
      db.loadData();
    }
    super.initState();
  }


  void checkedBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }


  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([
        _controller.text,
        false,
        DateTime.now(),
      ]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }



  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  void _onDaySelected(DateTime day, DateTime forcusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To Do App',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'en_us',
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            calendarFormat: CalendarFormat.month,
            focusedDay: today,
            onDaySelected: _onDaySelected,
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            firstDay: DateTime.utc(2000, 01, 01),
            lastDay: DateTime.utc(2030, 01, 01),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChanged: (value) => checkedBoxChanged(value, index ),
                deleteFunction: (context) => deleteTask(index),
              );
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          createNewTask();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
