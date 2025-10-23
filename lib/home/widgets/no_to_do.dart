import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class NoToDo extends StatelessWidget{
  final String tasks = "범수's Tasks"; 
 
 @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 230,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).dividerColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 12),
                    Image.asset(
                      'assets/tasks_image.webp',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 12),
                    Text('아직 할 일이 없음',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface
                    ),),
                    SizedBox(height: 12),
                    Text("할 일을 추가하고 $tasks에서 \n 할 일을 추가하세요.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface
                    ),)
                  ],
                ),
              ),
            ),
    );
}
}