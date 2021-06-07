import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pencilwith/models/termmodel.dart';
import 'package:pencilwith/pages/account.dart';

class TermsPage extends StatefulWidget {
  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool selected1 = false;
  bool selected2 = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 25, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Text(
              '펜슬위드 약관',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            _getTermContent(15.0),
            Spacer(),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      this.selected1 = !this.selected1;
                    });
                  },
                  child: Row(
                    children: [
                      CircularCheckBox(
                          value: this.selected1,
                          checkColor: Colors.white,
                          activeColor: Colors.grey,
                          inactiveColor: Colors.grey,
                          disabledColor: Colors.grey,
                          onChanged: (val) => this.setState(() {
                                this.selected1 = !this.selected1;
                              })),
                      Text(
                        '이용 약관 동의',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      this.selected2 = !this.selected2;
                    });
                  },
                  child: Row(
                    children: [
                      CircularCheckBox(
                          value: this.selected2,
                          checkColor: Colors.white,
                          activeColor: Colors.grey,
                          inactiveColor: Colors.grey,
                          disabledColor: Colors.grey,
                          onChanged: (val) => this.setState(() {
                                this.selected2 = !this.selected2;
                              })),
                      Text(
                        '개인정보 수집 동의서',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Get.off(Account());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 60,
                child: Center(
                  child: Text(
                    '동의 후 계속',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget _getTermContent(double size) {
    return Text.rich(
      TextSpan(text: termContent, style: TextStyle(fontSize: size)),
    );
  }
}
