import 'package:flutter/material.dart';
import 'package:pencilwith/pages/profile/agreement.dart';

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
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.menu),
        //     onPressed: () {},
        //     color: Colors.black,
        //   )
        // ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      endDrawer: Drawer(
          elevation: 20.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('냥냥이'),
                accountEmail: Text('developine.com@gmail.com'),
              ),
              ListTile(
                leading: Icon(Icons.assignment_ind),
                title: Text('프로필 편집'),
                onTap: () {
                  // This line code will close drawer programatically....
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.ballot),
                title: Text('원고관리'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.article),
                title: Text('이용약관'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Agreement()));
                },
              ),
              ListTile(
                leading: Icon(Icons.assignment_return),
                title: Text('로그아웃'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person_remove_rounded),
                title: Text('회원탈퇴'),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          )),
      body: ListView(
        children: [imageSection, infoSection, intoroduceSection],
      ),
    );
  }
}

Widget imageSection = Container(
  margin: const EdgeInsets.all(20),
  child: Center(
    child: CircleAvatar(
      radius: 70.0,
      backgroundImage: AssetImage('images/cat.jpg'),
    ),
  ),
);

Widget infoSection = Container(
  padding: const EdgeInsets.all(12),
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
      ], mainAxisAlignment: MainAxisAlignment.spaceEvenly));
}

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
          child: SingleChildScrollView(
            child: Text(
                '냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥냐아옹냥옹냥냥우앙엥'),
          )),
    ],
  ),
);

void showMessage(String test) {
  print(test);
}
