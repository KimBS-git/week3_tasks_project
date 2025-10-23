import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week3_project/home/widgets/no_to_do.dart';
import 'package:week3_project/description_page.dart';

typedef voidCallback = void Function(int index, bool newFavoriteStatus);

class ToDoView extends StatelessWidget{
  const ToDoView({
    super.key,
    required this.tasksList,
    required this.onTaskDelete,
    required this.onToggleFavorite
    });
    final List<Map<String, dynamic>> tasksList;
    final Function(int index) onTaskDelete;
    final voidCallback onToggleFavorite;
  @override
  Widget build(BuildContext context) {
    if(tasksList.isEmpty){
      return NoToDo();
    }
    return Expanded(
      child: ListView.builder(
          itemCount: tasksList.length,
          itemBuilder: (context, index){
            final task = tasksList[index];
            return ToDoItem(
              taskText: task['title'] as String,
              isFavorite: task['isFavorite'] as bool, 
              description: task['description'] as String? ?? '',
              onDelete: () => onTaskDelete(index),
              taskIndex: index,
              onToggleFavorite: onToggleFavorite
            );
          },
          ),
      );
    
  }
}
class ToDoItem extends StatefulWidget{
  final String taskText;
  final bool isFavorite;
  final String description;
  final VoidCallback onDelete;
  final int taskIndex;
  final voidCallback onToggleFavorite;

  const ToDoItem({
    super.key,
    required this.taskText,
    required this.isFavorite,
    required this.description,
    required this.onDelete,
    required this.taskIndex,
    required this.onToggleFavorite
  });
  @override
  State<ToDoItem> createState() => _ToDoItemState();
}
class _ToDoItemState extends State<ToDoItem>{
  late bool isCircleSelected;
  late bool _isFavorite;
void initState(){
  super.initState();

  isCircleSelected = false;
  _isFavorite = widget.isFavorite;
}

void _toggleCircle(){
    setState(() {
      isCircleSelected = !isCircleSelected;
    });
  }

void _toggleFavorite(){
  setState(() {
    _isFavorite = !_isFavorite;
  });
  widget.onToggleFavorite(widget.taskIndex, _isFavorite);
}

void _navigateToDescription(BuildContext context) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DescriptionPage(
        title: widget.taskText, 
        description: widget.description, 
        isFavorite: _isFavorite),
        ),
        );
        if(result is bool && result != _isFavorite){
          setState(() {
            _isFavorite = result;
          });
          widget.onToggleFavorite(widget.taskIndex, result);
        }
}
void _showDeleteConfirmation(BuildContext context){
  showDialog(
    context: context,
     builder: (BuildContext context){
       return CupertinoAlertDialog(
        title: const Text('할 일을 삭제하시겠습니까?'),
        content: Text("\'${widget.taskText}\' "),
        actions: <Widget>[
          TextButton(
            child: const Text('취소', style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Navigator.of(context).pop();
     },
     ),
     TextButton(
            child: const Text('삭제', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(context).pop();
              widget.onDelete(); 
            },
          ),
        ],
       );
},
  );
}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDescription(context),
      onLongPress: () => _showDeleteConfirmation(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).dividerColor
           
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: _toggleCircle, 
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                   isCircleSelected ? Icons.check_circle : Icons.circle_outlined,
                  ),
                ),
              ),
              Text(
                widget.taskText,
                style: TextStyle(
                  decoration: isCircleSelected ? TextDecoration.lineThrough : null,
                ),
              ),
              const Spacer(),
                GestureDetector(
                  onTap: (isCircleSelected) ? null : _toggleFavorite,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    _isFavorite ? Icons.star : Icons.star_border)),
                    ),
            ],
          ),
          ),
          ),
    ); 
  }
  }
