import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pencilwith/main.dart';
import 'package:pencilwith/pages/profile/manuscript.dart';

import '../main.dart';
import 'agreement/agreement.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  String _nickName;
  String _gender;
  String _birth;
  String _experience;
  String _location;
  String _introduction;
  String _id;

  @override
  initState() {
    super.initState();
    _nickName = 'asdasd';
    _gender = '남성';
    _birth = '2000.02.04';
    _experience = 'NEWBIE';
    _location = '서울';
    _introduction = '하이용sadsadsad';
    _id = 'google@gmail.com';
  }

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
        iconTheme: IconThemeData(color: Colors.black),
      ),
      endDrawer: Drawer(
          elevation: 20.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: new BoxDecoration(
                  color: new Color(0xffF0A8AB),
                ),
                accountName: Text(_nickName),
                accountEmail: Text(_id),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Manuscript()));
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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CoustomDialog('로그아웃');
                      });
                },
              ),
              ListTile(
                leading: Icon(Icons.person_remove_rounded),
                title: Text('회원탈퇴'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CoustomDialog('회원탈퇴');
                      });
                },
              )
            ],
          )),
      body: ListView(
        children: [
          imageSection,
          InfoSection(_nickName, _gender, _birth, _location, _experience),
          IntoroduceSection(_introduction)
        ],
      ),
    );
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
}

class InfoSection extends StatelessWidget {
  final nickName;
  final gender;
  final birth;
  final location;
  final experience;
  InfoSection(
      this.nickName, this.gender, this.birth, this.location, this.experience);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          RowInfo('닉네임', this.nickName),
          RowInfo('성별', this.gender),
          RowInfo('생년월일', this.birth),
          RowInfo('지역', this.location),
          RowInfo('작가역량', this.experience),
        ],
      ),
    );
  }
}

class IntoroduceSection extends StatelessWidget {
  final introduction;
  IntoroduceSection(this.introduction);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            '자기소개',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.all(12),
              width: 350,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: SingleChildScrollView(
                child: Text(introduction),
              )),
        ],
      ),
    );
  }
}

class RowInfo extends StatelessWidget {
  final tag;
  final val;
  RowInfo(this.tag, this.val);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15),
        child: Row(children: [
          Container(
            alignment: Alignment.center,
            width: 140,
            child: Text(
              this.tag,
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
              this.val,
              style: TextStyle(fontSize: 15),
            ),
          )
        ], mainAxisAlignment: MainAxisAlignment.spaceEvenly));
  }
}

Widget RowInfo1({String tag, String val}) {
  return Container(
      margin: const EdgeInsets.all(15),
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

void showMessage(String test) {
  print(test);
}

class CoustomDialog extends StatelessWidget {
  final title;
  CoustomDialog(this.title);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        child: Column(
          children: [
            Expanded(
                child: Container(
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        '''펜슬위드에서 
$title하시겠습니까?''',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ))),
            Expanded(
                child: Container(
                    child: ButtonTheme(
                        minWidth: 200,
                        child: Column(
                          children: [
                            RaisedButton(
                              onPressed: () {
                                //todo google logout or kakao logout
                                Firebase.initializeApp().then((value) {
                                  FirebaseAuth.instance.signOut();
                                  Get.off(() => MyApp());
                                });
                                //commonFireßbaseAuth.instance.signOut();
                              },
                              color: Colors.white,
                              child: Text(title,
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w600)),
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Colors.white,
                              child: Text(
                                '취소',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ))))
          ],
        ),
      ),
    );
  }
}
