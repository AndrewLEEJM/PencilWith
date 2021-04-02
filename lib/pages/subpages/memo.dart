import 'package:flutter/material.dart';
import 'package:pencilwith/models/todolistmodel.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';

class MemoPage extends StatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey[300],
            // child: Swiper(
            //   itemCount: 50,
            //   itemBuilder: (context, index) {
            //     return null;
            //   },
            // )
          ),
          flex: 4,
        ),
        Expanded(
          child: Container(
            //color: Colors.grey[400],
            child: _getTodoList(),
          ),
          flex: 3,
        ),
      ],
    ));
  }

  Widget _getTodoList() {
    bool _ischecked = false;
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CheckboxListTile(
                  onChanged: (value) {
                    setState(() {
                      todoList[index]['isDone'] = value;
                    });
                  },
                  dense: false,
                  activeColor: Colors.grey,
                  isThreeLine: false,
                  selected: todoList[index]['isDone'], //체크여부
                  value: todoList[index]['isDone'], //체크박스 값(표시)
                  title: Text('${todoList[index]['content']}')
                  // !done
                  //     ? Text('${todoList[index]['content']}')
                  //     : Text(
                  //         '${todoList[index]['content']}',
                  //         style:
                  //             TextStyle(decoration: TextDecoration.lineThrough),
                  //       ),
                  ),
            ],
          );
        });
  }
}
