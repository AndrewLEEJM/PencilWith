import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:pencilwith/main.dart';
import 'package:pencilwith/models/getxcontroller.dart';
import 'package:pencilwith/models/userprofile.dart';
import 'package:pencilwith/pages/profile/editprofile.dart';
import 'package:pencilwith/pages/profile/manuscript.dart';
import 'package:pencilwith/values/commonfunction.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'agreement/agreement.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  @override
  initState() {
    print('show page this ${prefs.getString('userId')}');
    super.initState();
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
                accountName: GetBuilder<Controller>(
                  init: Controller(),
                  builder: (controller) {
                    return Text('${controller.userProfile.name}님 반갑습니다.');
                  },
                ),
                // accountEmail: Text('_메일없어요@메일없어요'),
              ),
              ListTile(
                leading: Icon(Icons.assignment_ind),
                title: Text('프로필 편집'),
                onTap: () {
                  // This line code will close drawer programatically....
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
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
          Container(
            margin: const EdgeInsets.all(20),
            child: Center(
              child: GetBuilder<Controller>(
                init: Controller(),
                builder: (controller) {
                  return CircleAvatar(
                    radius: 70.0,
                    backgroundImage:
                        NetworkImage('${controller.userProfile.profileImage}'),
                  );
                },
              ),
            ),
          ),
          GetBuilder<Controller>(
            init: Controller(),
            builder: (controller) {
              return InfoSection(
                  '${controller.userProfile.name}',
                  '${controller.userProfile.genderType}',
                  '${controller.userProfile.birth}',
                  '${controller.userProfile.locationType}',
                  '${controller.userProfile.careerType}');
            },
          ),
          GetBuilder<Controller>(
            init: Controller(),
            builder: (controller) {
              return IntoroduceSection(
                  '${controller.userProfile.introduction}');
            },
          ),
        ],
      ),
    );
  }

  // Widget imageSection = Container(
  //   margin: const EdgeInsets.all(20),
  //   child: Center(
  //     child: CircleAvatar(
  //       radius: 70.0,
  //       backgroundImage: NetworkImage('${userProfile.profileImage.toString()}'),
  //     ),
  //   ),
  // );
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
                                if (title == '로그아웃') {
                                  if (prefs.getString('Div') == 'google') {
                                    Firebase.initializeApp().then((value) {
                                      resetPrefs();
                                      FirebaseAuth.instance.signOut();
                                      googleSignIn.signOut();
                                      Get.off(() => MyApp());
                                    });
                                  } else if (prefs.getString('Div') ==
                                      'kakao') {
                                    logOutTalk();
                                    resetPrefs();
                                    Get.off(() => MyApp());
                                  }
                                } else if (title == '회원탈퇴') {
                                  dropOut(
                                      Get.find<Controller>().userProfile.id);
                                }
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

  logOutTalk() async {
    try {
      var code = await UserApi.instance.logout();
    } catch (e) {
      print(e);
    }
  }

  unlinkTalk() async {
    try {
      var code = await UserApi.instance.unlink();
    } catch (e) {
      print(e);
    }
  }

  resetPrefs() {
    prefs.setString('JwtToken', null);
    prefs.setString('Div', null);
    prefs.setString('UserId', null);
  }

  Future<void> dropOut(String userId) async {
    var url = 'https://pencil-with.com/api/my/user/$userId';

    print(url);

    var response = await http.delete(
      url,
      headers: {
        'Content-type': 'application/json ; charset=utf-8',
        'Authorization': prefs.getString('JwtToken')
      },
    );

    if (response.statusCode == 200) {
      resetPrefs();
      Get.off(() => MyApp());
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
