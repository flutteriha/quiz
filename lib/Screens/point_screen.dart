import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class PointScreen extends StatefulWidget {
  PointScreen({Key? key}) : super(key: key);

  @override
  State<PointScreen> createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            List<String> resultList = snapshot.data as List<String>;
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
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.infoReverse,
                        animType: AnimType.bottomSlide,
                        title: 'مطمئنی میخوای لیست رو پاک کنی؟',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          setState(() {
                            onOkPressed();
                          });
                        },
                      ).show();
                    },
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                  body: Column(
                    children: [
                      Expanded(child: Image.asset('assets/images/point.png')),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 40.0),
                          decoration: const BoxDecoration(
                            // gradient: LinearGradient(
                            //   colors: [
                            //     status == 'winner' ? kLightGreenColor : kLightRedColor,
                            //     Colors.white,
                            //   ],
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            // ),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: size.width,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 4,
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'Player Name',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.disabled_by_default_rounded,
                                          color: Colors.red,
                                          size: 40.0,
                                        ),
                                        SizedBox(width: 10.0),
                                        Icon(
                                          Icons.check_box,
                                          color: Colors.green,
                                          size: 40.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width,
                                height: size.height / 1.81,
                                child: ListView.builder(
                                  itemCount: resultList.length,
                                  itemBuilder: (context, index) {
                                    double trueAnswers = double.parse(
                                        resultList[index].split('/')[1]);
                                    double falseAnswers = double.parse(
                                        resultList[index].split('/')[2]);

                                    return Container(
                                      width: size.width,
                                      height: 60.0,
                                      margin: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: trueAnswers > falseAnswers
                                            ? kLightGreenColor
                                            : kLightRedColor,
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              resultList[index].split('/')[0],
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Text(
                                                  resultList[index]
                                                      .split('/')[2],
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 40.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(width: 30.0),
                                                Text(
                                                  resultList[index]
                                                      .split('/')[1],
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 40.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<String>> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList('scores') ?? [];
  }

  void onOkPressed() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
