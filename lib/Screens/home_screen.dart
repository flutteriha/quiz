import 'package:flutter/material.dart';
import '../Screens/result_screen.dart';
import '../Models/question_model.dart';
import '../constants.dart';

enum Pressed {
  btn1,
  btn2,
  none,
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Size size;
  late AnimationController controller;
  late Animation animation;
  ScrollController scrollController = ScrollController();
  Pressed? pressed;
  int currentQuestionNumber = 0;
  List statusList = [];

  void nextQuestion() {
    scrollController.animateTo(currentQuestionNumber * 70,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    setState(() {
      checkAnswer();
    });
    if (currentQuestionNumber >= questionList.length - 1) {
      myNavigator();
    } else {
      setState(() {
        currentQuestionNumber++;
      });
    }
  }

  checkAnswer() {
    int numAnswer = 2;
    if (pressed == Pressed.btn1) {
      numAnswer = 0;
      controller.reset();
      controller.forward();
    } else if (pressed == Pressed.btn2) {
      numAnswer = 1;
      controller.reset();
      controller.forward();
    }
    bool status = questionList[currentQuestionNumber].isRight(numAnswer);
    statusList[currentQuestionNumber] = status;
    pressed = Pressed.none;
  }

  List<int> calculate() {
    int trueAnswer = 0;
    int falseAnswer = 0;
    for (var item in statusList) {
      if (item == true) {
        trueAnswer++;
      } else {
        falseAnswer++;
      }
    }
    return [trueAnswer, falseAnswer];
  }

  myNavigator() {
    controller.reset();
    controller.dispose();
    List<int> resultList = calculate();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(resultList: resultList),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < questionList.length; i++) {
      statusList.add(0);
    }
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          int animationValue = (animation.value * 100).round().toInt();
          if (animationValue >= 98) {
            nextQuestion();
            if (controller.isAnimating) {
              controller.reset();
              controller.forward();
            }
          }
        });
      });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kLightBlueBackgroundColor,
            kDarkBlueBackgroundColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 30.0),
                Container(
                  height: 20.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: LinearProgressIndicator(
                      value: animation.value,
                      backgroundColor: kLightBlueColor,
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                  width: size.width,
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: questionList.length,
                    itemBuilder: (context, index) {
                      Color color = kLightBlueColor;
                      if (index == currentQuestionNumber) {
                        if (index == questionList.length - 1 &&
                            statusList[index] != 0) {
                          if (statusList[index] == true) {
                            color = kLightGreenColor;
                          } else if (statusList[index] == false) {
                            color = kLightRedColor;
                          }
                        } else {
                          color = Colors.white;
                        }
                      } else {
                        if (statusList[index] == true) {
                          color = kLightGreenColor;
                        } else if (statusList[index] == false) {
                          color = kLightRedColor;
                        }
                      }
                      return Container(
                        width: index == currentQuestionNumber ? 70.0 : 60.0,
                        height: index == currentQuestionNumber ? 70.0 : 60.0,
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize:
                                  index == currentQuestionNumber ? 50.0 : 30.0,
                              fontWeight: FontWeight.bold,
                              color: index == currentQuestionNumber
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 400.0,
                  width: size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        bottom: 0.0,
                        child: Container(
                          height: 300.0,
                          width: size.width / 2.5,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25.0,
                        child: Container(
                          height: 300.0,
                          width: size.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      Container(
                        height: 300.0,
                        width: size.width / 1.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          gradient: const LinearGradient(
                            colors: [
                              kLightBlueColor,
                              Colors.white,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(height: 100.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                questionList[currentQuestionNumber].question,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkBlueColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      pressed = Pressed.btn1;
                                      nextQuestion();
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: pressed == Pressed.btn1
                                        ? MaterialStateProperty.all(
                                            kPurpleColor)
                                        : MaterialStateProperty.all(
                                            kLightBlueColor),
                                    fixedSize: MaterialStateProperty.all(
                                      const Size(100.0, 50.0),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    questionList[currentQuestionNumber].answer1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      pressed = Pressed.btn2;
                                      nextQuestion();
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: pressed == Pressed.btn2
                                        ? MaterialStateProperty.all(
                                            kPurpleColor)
                                        : MaterialStateProperty.all(
                                            kLightBlueColor),
                                    fixedSize: MaterialStateProperty.all(
                                      const Size(100.0, 50.0),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    questionList[currentQuestionNumber].answer2,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        child: Image.asset(
                          questionList[currentQuestionNumber].imageAddress,
                          width: 150.0,
                          height: 150.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () => nextQuestion(),
                        child: Container(
                          height: 80.0,
                          decoration: const BoxDecoration(
                            color: kLightBlueColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    Expanded(
                      child: Container(
                        height: 80.0,
                        decoration: const BoxDecoration(
                          color: kPurpleColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child: Center(
                          child: Image.asset('assets/images/flag.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
