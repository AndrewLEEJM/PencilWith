import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'P R O F I L E',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          settingIcon,
          imageSection,
          infoSection,
          intoroduceSection,
          btnGroup
        ],
      ),
    );
  }
}

Widget settingIcon = Row(children: [
  IconButton(
    icon: Icon(Icons.settings),
    onPressed: () => showMessage('IconButton'),
  ),
], mainAxisAlignment: MainAxisAlignment.end);

Widget imageSection = Container(
  child: Center(
    child: CircleAvatar(
      radius: 70.0,
      backgroundImage: AssetImage('images/cat.jpg'),
    ),
  ),
);

Widget infoSection = Container(
  padding: const EdgeInsets.all(12),
  // color: Colors.pink,
  child: Column(
    children: [
      RowInfo(tag: '닉네임', val: '냥냥이'),
      RowInfo(tag: '성별', val: '남성'),
      RowInfo(tag: '생년월일', val: '2000년 07월 07일'),
      RowInfo(tag: '지역', val: '서울'),
      RowInfo(tag: '작가역량', val: '입문'),
    ],
  ),
);

Widget RowInfo({String tag, String val}) {
  return Container(
      margin: const EdgeInsets.all(10),
      child: Row(children: [
        Container(
          alignment: Alignment.center,
          width: 140,
          child: Text(
            tag,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        Container(
          width: 140,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ))),
          alignment: Alignment.center,
          child: Text(
            val,
            style: TextStyle(fontSize: 15),
          ),
        )
      ], mainAxisAlignment: MainAxisAlignment.center));
}

Widget btnGroup = Container(
  padding: const EdgeInsets.all(12),
  child: Row(children: [
    RaisedButton(
      child: Text('친구관리', style: TextStyle(fontSize: 20)),
      color: Colors.white,
      onPressed: () => showMessage('친구관리'),
    ),
    RaisedButton(
      child: Text('이용안내', style: TextStyle(fontSize: 20)),
      color: Colors.white,
      onPressed: () => showMessage('이용안내'),
    )
  ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
);

Widget intoroduceSection = Container(
  padding: const EdgeInsets.all(12),
  child: Column(
    children: [
      Text('자기소개'),
      Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
          ),
        ),
      )
    ],
  ),
);

void showMessage(String test) {
  print(test);
}
