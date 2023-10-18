// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:eng_bti/view/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  bool isEmptyAnswers() {
    if (selectedAnswers.length != questions.length) {
      // 아직 응답하지 않은 질문이 있다면
      return true;
    } else {
      // 모든 질문에 응답한 경우
      return false;
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
    // print('mbitList: $mbitList');
  }

  ScrollController _scrollController = ScrollController();

  void _scrollToNextQuestion(int currentIndex) {
    if (currentIndex < questions.length - 1) {
      final nextIndex = currentIndex + 1;
      // 현재 질문이 첫 번째 질문이고 선택이 된 경우
      if (currentIndex == 0 ||
          selectedAnswers[questions[currentIndex]['id']] != null) {
        Scrollable.ensureVisible(
          questionKeys[nextIndex].currentContext!,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.5,
        );
      }
    }
  }

  bool isFirstCard = true;

  List<GlobalKey> questionKeys = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2B3EE),
        title: Text("MBTI 조사"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              controller: _scrollController,
              itemCount: questions.length,
              itemBuilder: (context, index) {
                GlobalKey key = GlobalKey();
                questionKeys.add(key);

                // 중앙에 배치되는 카드에 대한 스타일 조건 확인
                final isCenterCard = index == selectedAnswers.length;
                final cardPadding = isCenterCard
                    ? EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0)
                    : EdgeInsets.all(16.0);
                final cardMargin = isCenterCard
                    ? EdgeInsets.symmetric(horizontal: 5, vertical: 15)
                    : EdgeInsets.symmetric(horizontal: 20, vertical: 10);
                final cardColor = isCenterCard ? Colors.white : Colors.black12;
                final cardFontColor =
                    isCenterCard ? Colors.black : Colors.black45;

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: cardMargin,
                  key: questionKeys[index],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: cardColor,
                      width: isCenterCard ? 300.0 : double.infinity,
                      child: Padding(
                        padding: cardPadding,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Q.${index + 1} ${questions[index]["text"].toString()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: cardFontColor,
                                ),
                              ),
                            ),
                            RadioListTile(
                              title: Text(
                                '${questions[index]['choices'][0]['text']}',
                                style: TextStyle(
                                  color: cardFontColor,
                                ),
                              ),
                              value: questions[index]['choices'][0]['id']
                                  .toString(),
                              groupValue:
                                  selectedAnswers[questions[index]['id']],
                              onChanged: (value) {
                                if (index == 0 ||
                                    selectedAnswers[questions[index - 1]
                                            ['id']] !=
                                        null) {
                                  // 첫 번째 카드는 항상 허용하거나 이전 카드가 선택된 경우에만 허용
                                  setState(() {
                                    selectedAnswers[questions[index]['id']] =
                                        value!;
                                    _scrollToNextQuestion(index);
                                  });
                                }
                              },
                            ),
                            RadioListTile(
                              title: Text(
                                '${questions[index]['choices'][1]['text']}',
                                style: TextStyle(
                                  color: cardFontColor,
                                ),
                              ),
                              value: questions[index]['choices'][1]['id']
                                  .toString(),
                              groupValue:
                                  selectedAnswers[questions[index]['id']],
                              onChanged: (value) {
                                if (index == 0 ||
                                    selectedAnswers[questions[index - 1]
                                            ['id']] !=
                                        null) {
                                  // 첫 번째 카드는 항상 허용하거나 이전 카드가 선택된 경우에만 허용
                                  setState(() {
                                    selectedAnswers[questions[index]['id']] =
                                        value!;
                                    _scrollToNextQuestion(index);
                                  });
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 300,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: !isEmptyAnswers(),
        child: FloatingActionButton.extended(
            backgroundColor: Color(0xFFF2B3EE),
            onPressed: () {
              answersList = selectedAnswers.values.toList();
              test();
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      result_: mbitList.join(),
                    ),
                  ),
                );
              });
            },
            label: Text('제출하기')),
      ),
    );
  }
}
