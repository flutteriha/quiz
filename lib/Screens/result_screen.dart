import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutteriha_quiz/Screens/point_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({
    Key? key,
    required this.resultList,
  }) : super(key: key);

  final List<int> resultList;
  late Size size;
  String status = '';

  TextEditingController controller = TextEditingController();

  void onOkPressed(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList('scores') ?? [];
    list.add('${controller.text}/${resultList[0]}/${resultList[1]}');
    await pref.setStringList('scores', list);
    print(pref.getStringList('scores'));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PointScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (resultList[0] > resultList[1]) {
      status = 'winner';
    } else {
      status = 'loser';
    }
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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height / 1.2,
                  margin: const EdgeInsets.symmetric(horizontal: 40.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        status == 'winner' ? kLightGreenColor : kLightRedColor,
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                  ),
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 30.0,
                            right: 30.0,
                            top: 100.0,
                            bottom: 15.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15.0),
                              Text(
                                'Your are\n${status == 'winner' ? 'winner!' : 'loser!'}',
                                style: TextStyle(
                                  color: status == 'winner'
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: size.width / 2,
                                child: Divider(
                                  color: status == 'winner'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.check_box,
                                        color: Colors.green,
                                        size: 40.0,
                                      ),
                                      const Text(
                                        'correct',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${resultList[0]}',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.disabled_by_default_rounded,
                                        color: Colors.red,
                                        size: 40.0,
                                      ),
                                      const Text(
                                        ' wrong ',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${resultList[1]}',
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0.0,
                          child: Image(
                            width: status != 'winner' ? 150.0 : null,
                            image: AssetImage(
                              'assets/images/${status == 'winner' ? 'winner' : 'loser'}.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.infoReverse,
                            animType: AnimType.bottomSlide,
                            title: 'میخوای از اول بازی کنی؟',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {
                              Phoenix.rebirth(context);
                            },
                          ).show();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber),
                          fixedSize: MaterialStateProperty.all(
                            const Size(150.0, 60.0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Play again',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.infoReverse,
                            animType: AnimType.bottomSlide,
                            body: TextField(
                              controller: controller,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Player Name',
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Colors.blue,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {
                              onOkPressed(context);
                            },
                          ).show();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          fixedSize: MaterialStateProperty.all(
                            const Size(150.0, 60.0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'results',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
