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
  List<String> answersList = [];
  int sumE = 0;
  int sumI = 0;
  int sumS = 0;
  int sumN = 0;
  int sumT = 0;
  int sumF = 0;
  int sumJ = 0;
  int sumP = 0;
  List<String> mbitList = ["", "", "", ""];

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
      print(selectedAnswers);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("모든 질문에 응답해주세요.")));

      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(result_: mbitList.join(),),
          ),
        );
      });
    } else {
      // 모든 질문에 응답한 경우
      // 선택된 응답들을 리스트로 변환
      answersList = selectedAnswers.values.toList();
      print(answersList); // 변환된 응답 리스트 출력
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(result_: mbitList.join(),),
          ),
        );
      });
      // TODO: 다음 작업을 수행합니다.
    }
  }

  test() {
    for (int i = 0; i < answersList.length; i++) {
      if (i % 7 == 0) {
        if (answersList[i] == "A") {
          sumE += 1;
        } else if (answersList[i] == "B") {
          sumI += 1;
        }
      } else if (i % 7 == 1 || i % 7 == 2) {
        if (answersList[i] == "A") {
          sumS += 1;
        } else if (answersList[i] == "B") {
          sumN += 1;
        }
      } else if (i % 7 == 3 || i % 7 == 4) {
        if (answersList[i] == "A") {
          sumT += 1;
        } else if (answersList[i] == "B") {
          sumF += 1;
        }
      } else if (i % 7 == 5 || i % 7 == 6) {
        if (answersList[i] == "A") {
          sumJ += 1;
        } else if (answersList[i] == "B") {
          sumP += 1;
        }
      }
    }
    print('sumE: $sumE');
    print('sumI: $sumI');
    print('sumS: $sumS');
    print('sumN: $sumN');
    print('sumT: $sumT');
    print('sumF: $sumF');
    print('sumJ: $sumJ');
    print('sumP: $sumP');

    sumE >= sumI ? mbitList[0] = "E" : mbitList[0] = "I";
    sumS >= sumN ? mbitList[1] = "S" : mbitList[1] = "N";
    sumT >= sumF ? mbitList[2] = "T" : mbitList[2] = "F";
    sumJ >= sumP ? mbitList[3] = "J" : mbitList[3] = "P";

    sumE = 0;
    sumI = 0;
    sumS = 0;
    sumN = 0;
    sumT = 0;
    sumF = 0;
    sumJ = 0;
    sumP = 0;

    print('mbitList: $mbitList');
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
                  onPressed: () {
                    _checkEmptyAnswers();
                    test();
                  },
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
                          Bounce(
                            infinite: true,
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

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.result_});
  final String result_;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late String userMBTI;
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

    // characteristic = results[userMBTI]["characteristic"];
    // strength = results[userMBTI]["strength"];
    // weakness = results[userMBTI]["weakness"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2B3EE),
      appBar: AppBar(
        title: Text("MBTI 결과"),
      ),
      body: Center(
        child: ListView(children: [
          Container(
            padding: EdgeInsets.only(top: 80, bottom: 40),
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
            width: 200,
            child: ClipOval(
                child: Image.asset(
                  'assets/images/$userMBTI.jpg',
                )),
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            color: Colors.purple,
            child: Column(
              children: [
                Text(
                  "특징: ${results["ENFJ"]["characteristic"]}",
                  style: TextStyle(fontSize: 18),
                ),
                Text("장점: ${results["ENFJ"]["strength"]}",
                    style: TextStyle(fontSize: 18)),
                Text("단점: ${results["ENFJ"]["weakness"]}",
                    style: TextStyle(fontSize: 18)),
                // Text("장점: $strength"),
                // Text("단점: $weakness"),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
