import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week3_project/home/widgets/no_to_do.dart';
import 'package:week3_project/home/widgets/to_do_view.dart';

class HomePage extends StatefulWidget{
const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final String tasks = "범수's Tasks";
final List<Map<String, dynamic>> _todolist = [];
final TextEditingController _textController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();

@override
void dispose() { 
  _textController.dispose();
  _descriptionController.dispose();
  super.dispose();
}
void _desciptionTask(int index){
  setState(() {
    _todolist.removeAt(index);
  });
}
void _toggleFavoriteStatus(int index, bool newFavoriteStatus){
  setState(() {
    if (index >= 0 && index < _todolist.length){
      _todolist[index]['isFavorite'] = newFavoriteStatus;
    }
  });
}
void AddTodo(BuildContext context){
     bool isStarSelected = false;
      bool showDescriptionField = false;
      bool isSaveButton = false;
    _textController.text = '';
    _descriptionController.text = '';

      void showTodoRequiredSnackBar() {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text('할 일을 입력해주세요.'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin : EdgeInsets.all(20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            )
          );
          
        }

  showModalBottomSheet(context: context,
  isScrollControlled: true,

  builder: (BuildContext context){
    return StatefulBuilder(builder: (
      BuildContext context, StateSetter modalSetState){

        void updateSaveButtonState(){
          modalSetState((){
            isSaveButton = _textController.text.trim().isNotEmpty;
          });
        }

      
        final double baseHeight = 120 + MediaQuery.of(context).viewInsets.bottom;
       final double descriptionHeight = 180 + MediaQuery.of(context).viewInsets.bottom;
        final double currentHeight = showDescriptionField ? descriptionHeight : baseHeight;

    return Padding(padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,
    ),
    child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 0),
            height: currentHeight - MediaQuery.of(context).viewInsets.bottom, 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    autofocus: true,
                    onChanged: (value) => updateSaveButtonState(),
                    onSubmitted: (value) {
                      if(_textController.text.trim().isNotEmpty){
                        setState(() {
                          _todolist.add({
                            'title': _textController.text.trim(),
                            'isFavorite': isStarSelected,
                            'description': _descriptionController.text.trim(),
                          });
                        });
                      }
                      Navigator.pop(context); 
                    },
                    decoration: InputDecoration(
                      hintText: "새 할 일",
                      hintStyle: TextStyle(fontSize: 16),
                      border: InputBorder.none),
    ),
                ),
                if (showDescriptionField)
                Expanded(child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: '세부정보 추가',
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none
                  ),
                ),
                ),
                Row(
                children: [
                  if(!showDescriptionField)
                  IconButton(
                    icon: const Icon(Icons.short_text_rounded, size: 24),
                    onPressed: (){
                      modalSetState((){
                        showDescriptionField = !showDescriptionField;
                        if(!showDescriptionField) _descriptionController.text = '';
                      });
                    }
                    ),
                    IconButton(onPressed: (){
                      modalSetState((){
                        isStarSelected = !isStarSelected;
                      });
                    },
                     icon: Icon(
                      isStarSelected ? Icons.star : Icons.star_border,
                       size: 24)
                     ),
                    const Spacer(),
                    Opacity(opacity: isSaveButton ? 1.0 : 0.4,
                    child: TextButton(
              onPressed: (){
                if (_textController.text.trim().isNotEmpty){
                  setState(() {
                    _todolist.add({
                      'title': _textController.text.trim(),
                     'isFavorite': isStarSelected, 
                      'description': _descriptionController.text.trim(),
                    });
                  });
                   Navigator.pop(context);
                }else{
                  showTodoRequiredSnackBar();
                  Navigator.pop(context);
                }
               
              },
              child: const Text('저장'),
              ),
              ),
                     
  ],
              ),
            
              ]
),
),
);
  }
    );
  }
);
}
  

  @override
  Widget build(BuildContext context) {

   return Scaffold(
    appBar: AppBar(
      title: Text(tasks,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),),
    ),
    
    body: 
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       const SizedBox(height: 12),
        Expanded(child: ToDoView(
          tasksList: _todolist,
           onTaskDelete: _desciptionTask,
           onToggleFavorite: _toggleFavoriteStatus,)) 
      ]
        ),
        resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => AddTodo(context),
      backgroundColor: Colors.red,
      child: const Icon(Icons.add,
      color: Colors.white),
      ),
  floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );

  }

}
