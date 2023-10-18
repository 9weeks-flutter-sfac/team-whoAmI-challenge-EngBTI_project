// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class allMBTIPage extends StatefulWidget {
  const allMBTIPage({super.key});

  @override
  State<allMBTIPage> createState() => _allMBTIPageState();
}

class _allMBTIPageState extends State<allMBTIPage> {
  List<String> MBTI = [
    'ENFP',
    'ENFJ',
    'ENTP',
    'ENTJ',
    'ESFP',
    'ESFJ',
    'ESTP',
    'ESTJ',
    'INFP',
    'INFJ',
    'INTP',
    'INTJ',
    'ISFP',
    'ISFJ',
    'ISTP',
    'ISTJ',
  ];

  void initState() {
    super.initState();
    _loadResult();
  }

  Map<String, dynamic> results = {};

  _loadResult() async {
    String jsonString = await rootBundle.loadString('assets/result.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    setState(() {
      results = jsonMap['result'];
    });

    setState(() {});
  }

  showResultDialog(BuildContext context, String mbti) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Container(
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
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
                      '${results[mbti]["characteristic"]}',
                      style: TextStyle(fontSize: 18),
                      // textAlign: TextAlign.center,
                    ),
                    Divider(
                      color: Color(0xFFF2B3EE),
                      thickness: 2.5,
                      indent: 15,
                      endIndent: 15,
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
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 21),
                        ),
                        Icon(
                          Icons.favorite,
                          color: Color(0xFFF2B3EE),
                        ),
                      ],
                    ),
                    Text(
                      '${results[mbti]["strength"]}',
                      style: TextStyle(fontSize: 18),
                      // textAlign: TextAlign.center,
                    ),
                    Divider(
                      color: Color(0xFFF2B3EE),
                      thickness: 2.5,
                      indent: 15,
                      endIndent: 15,
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
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 21),
                        ),
                        Icon(
                          Icons.favorite,
                          color: Color(0xFFF2B3EE),
                        ),
                      ],
                    ),
                    Text(
                      '${results[mbti]["weakness"]}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      // textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전체 유형'),
        foregroundColor: Color(0xFFF2B3EE),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        color: Color(0xFFF2B3EE),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: MBTI.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                showResultDialog(context, MBTI[index]);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ClipOval(
                        child: Image.asset(
                      'assets/images/${MBTI[index]}.jpg',
                    )),
                  ),
                  Text(
                    MBTI[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
