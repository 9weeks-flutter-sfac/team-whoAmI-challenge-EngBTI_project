import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuestionPage(),
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
        title: Text("MBTI 조사"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: questions.map((question) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(question['text']),
                      ),
                      ...question['choices'].map<Widget>((choice) {
                        return RadioListTile<String>(
                          title: Text(choice['text']),
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
                  );
                }).toList(),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 10.0,
            right: 10.0,
            child: ElevatedButton(
              onPressed: _checkEmptyAnswers,
              child: Text("empty check"),
            ),
          ),
        ],
      ),
    );
  }
}
