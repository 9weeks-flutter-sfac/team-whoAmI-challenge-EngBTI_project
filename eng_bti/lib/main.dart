import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<dynamic> questions = [];
  Map<int, String> selectedAnswers = {}; // 각 질문에 대한 응답을 추적하기 위한 맵

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  _loadQuestions() async {
    String jsonString = await rootBundle.loadString('assets/questions.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    setState(() {
      questions = jsonMap['questions'];
    });
  }

  _checkEmptyAnswers() {
    if (selectedAnswers.length != questions.length) {
      // 아직 응답하지 않은 질문이 있다면
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("모든 질문에 응답해주세요.")));
    } else {
      // 모든 질문에 응답한 경우
      // TODO: 다음 작업을 수행합니다.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2B3EE),
        title: Text("MBTI 조사"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: questions.map((question) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                ' Q. ' + question["text"],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ...question['choices'].map<Widget>((choice) {
                              return RadioListTile<String>(
                                title:
                                Text(choice['id'] + ': ' + choice['text']),
                                value: choice['id'],
                                groupValue: selectedAnswers[question['id']],
                                onChanged: (value) {
                                  setState(() {
                                    selectedAnswers[question['id']] = value!;
                                  });
                                },
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    }).toList(), // 여기에 버튼 추가.
                  ),
                ),
                ElevatedButton(
                  onPressed: _checkEmptyAnswers,
                  child: Text("제출하기"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/mainPageImg.jpg",
              fit: BoxFit.contain,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white54),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          BounceInUp(
                            key: UniqueKey(),
                            child: Text(
                              '엥?',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "BTI",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      // 나머지 위젯들
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF2B3EE),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionPage(),
                            ),
                          );
                        },
                        child: Text('검사 시작'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
