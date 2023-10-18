// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:eng_bti/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.result_});
  final String? result_;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late String? userMBTI;
  var characteristic;
  var strength;
  var weakness;

  Map<String, dynamic> results = {};

  void initState() {
    super.initState();
    userMBTI = widget.result_;
    _loadResult();
  }

  _loadResult() async {
    String jsonString = await rootBundle.loadString('assets/result.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    setState(() {
      results = jsonMap['result'];
    });

    characteristic = results[userMBTI]["characteristic"];
    strength = results[userMBTI]["strength"];
    weakness = results[userMBTI]["weakness"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2B3EE),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Color(0xFFF2B3EE),
        backgroundColor: Colors.white,
        title: Text("MBTI 결과"),
      ),
      body: Center(
        child: ListView(children: [
          Container(
            padding: EdgeInsets.only(top: 40, bottom: 40),
            alignment: Alignment.center,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "엥?\n",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "내가 ",
                  style: TextStyle(fontSize: 24, color: Colors.black54)),
              TextSpan(
                  text: userMBTI,
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.w800)),
              TextSpan(
                  text: " 라고??",
                  style: TextStyle(fontSize: 24, color: Colors.black54)),
            ])),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 40),
            width: 50,
            child: ClipOval(
                child: Image.asset(
              'assets/images/$userMBTI.jpg',
            )),
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Color(0xFFF2B3EE),
                      ),
                      Text(
                        '특징',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 21),
                      ),
                      Icon(
                        Icons.favorite,
                        color: Color(0xFFF2B3EE),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${characteristic}',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  color: Color(0xFFF2B3EE),
                  thickness: 2.5,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Color(0xFFF2B3EE),
                    ),
                    Text(
                      '장점',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Color(0xFFF2B3EE),
                    ),
                  ],
                ),
                Text(
                  '${strength}',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  color: Color(0xFFF2B3EE),
                  thickness: 2.5,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Color(0xFFF2B3EE),
                    ),
                    Text(
                      '단점',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 21),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Color(0xFFF2B3EE),
                    ),
                  ],
                ),
                Text(
                  '${weakness}',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFF2B3EE),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ));
                    },
                    child: Text("메인 화면으로"),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
