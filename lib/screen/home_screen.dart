import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noots/data/database.dart';
import 'package:noots/util/dialog_box.dart';
import 'package:noots/util/todo_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _myBox=Hive.box('myBox');
  ToDoDataBase db=ToDoDataBase();
  @override
  void initState() {
    if(_myBox.get("TODOLIST")==null){
      db.createInitialDate();
    }else{
      db.loadData();
    }
    super.initState();
  }
  final _controller=TextEditingController();
  void checkBoxChanged(bool?value,int index){
    setState(() {
      db.toDoList[index][1]=!db.toDoList[index][1];
    });
    db.updateDataBase();
  }
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }
  void createNewTak(){
    showDialog(
        context: context,
        builder: (context){
          return DialogBox
            (controller: _controller,
              onSave: saveNewTask,
              onCansel: ()=>Navigator.of(context).pop(),
          );
        });
  }
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        title: const Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(onPressed: createNewTak,
      child: const Icon(Icons.add),
      ),
      body:ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder:(context,index){
          return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value)=>checkBoxChanged(value, index),
              deleteFunction: (context)=>deleteTask(index),
          );
        },
      ) ,
    );
  }
}

