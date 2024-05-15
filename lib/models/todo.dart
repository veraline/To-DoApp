import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  bool status;
  @HiveField(2)
  DateTime dateCreated;
  Todo({this.title = '', this.status = false, required this.dateCreated});
}
