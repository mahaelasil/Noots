import 'package:hive/hive.dart';

class ToDoDataBase{
  List toDoList=[];
  final _myBox=Hive.box('myBox');
  void createInitialDate(){
    toDoList=[
      ['make tutorial',false],
      ['do exercise',false],
    ];
  }
  void loadData(){
    toDoList=_myBox.get('TODOLIST');
  }
  void updateDataBase(){
    _myBox.put("TODOLIST", toDoList);
  }
}