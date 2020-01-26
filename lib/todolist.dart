import 'package:flutter/material.dart';
import 'Todo.dart';

class DoList extends StatefulWidget {
  @override
  _DoListState createState() => _DoListState();
}

class _DoListState extends State<DoList> {
  List<Todo> todos = [];
  TextEditingController controller = TextEditingController();
  _todoCheck(Todo todo, bool isChecked) {
        setState(() {
      todo.isDone = isChecked;
    });
   }
   
    Widget _buildItem(BuildContext context, int index) {
     final todo = todos[index];
    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
      onChanged: (bool isChecked) {
    _todoCheck(todo, isChecked);
      },
     );
   }

_addTodo() async { // addTodo
final todo = await showDialog<Todo>(
       context: context,
       builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
           title: Text('New todo'),
           content: TextField(
           controller: controller,
           autofocus: true,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
               onPressed: () {
               Navigator.of(context).pop(); 
              },    
            ),
            FlatButton(
              child: Text("Add", style: TextStyle(color: Colors.blue),),
              onPressed: () {
              setState(() {
              final todo = new Todo(title: controller.value.text);
              if(controller.value.text == ""){
                print("");
              }else {
                todos.add(todo);
              }
                  controller.clear();
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );    
       },
     );
     
      if(todo != null) {
       setState(() {
         todos.add(todo);
       });
     }
   } 
   
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: todos.length,
       ),
       floatingActionButton: FloatingActionButton(
         child: Icon(Icons.add),
         onPressed: _addTodo,
       ),
    );
  }
}