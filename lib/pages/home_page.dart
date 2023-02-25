import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:flutter_unity_widget_example/models/gage_model.dart';
import 'package:flutter_unity_widget_example/providers/users_provider.dart';
import 'package:flutter_unity_widget_example/widgets/image_buttom.dart';
import 'package:flutter_unity_widget_example/widgets/specific/triangle_painter.dart';
import 'package:flutter_unity_widget_example/widgets/specific/whatNow/what_now_dialog.dart';
import 'package:go_router/go_router.dart';

import '../widgets/specific/sorryButton/sorry_dialog.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  late UnityWidgetController unityWidgetController;

  @override
  void dispose() {
    unityWidgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gage = ref.watch(GageProvider).gage;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: Expanded(
          child: Container(
            color: Color.fromARGB(255, 255, 239, 225),
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Expanded(child: Container()),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  DefaultTabController(
                    initialIndex: 0,
                    length: 2,
                    child: TabBarView(
                      children: [
                        SizedBox(
                          height: 250,
                          width: 250,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              UnityWidget(
                                onUnityCreated: onUnityCreated,
                                fullscreen: false,
                              ),
                              MaterialButton(
                                height: 200,
                                minWidth: 200,
                                onPressed: () => showWhatNow(context),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          width: 250,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              UnityWidget(
                                onUnityCreated: onUnityCreated,
                                fullscreen: false,
                              ),
                              MaterialButton(
                                height: 200,
                                minWidth: 200,
                                onPressed: () => showWhatNow(context),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    // elevation: 8.0,
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/SorryForLate.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return SorryGirdDialog();
                            // return EngageDialog();
                          });
                    },
                    // onPressed: () {}
                  ),
                ],
              ),
              Positioned(
                  right: 50,
                  top: 30,
                  child: CustomPaint(
                    size: Size(40, 40),
                    painter: DrawTriangle(ref),
                  )),
              Positioned(
                  left: 120,
                  top: 80,
                  width: 200,
                  child: Image.asset('images/whatNowStamp/WaitReply.png')),
              Positioned(
                  width: 70,
                  height: 70,
                  left: 50,
                  top: 220,
                  child: ref.watch(EngageStampProvider)

                  // ),
                  )
            ]),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showWhatNow(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          const workTimepath = 'whatNowStamp/WorkTime/';
          const whatnowpath = 'whatNowStamp/';
          return WhatNowDialog(
            childrenWork: [
              ImageButton(
                imageName: '${workTimepath}WorkGirl0.png',
                onPressd: (() {
                  setActive('WorkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${workTimepath}WorkGirl18.png',
                onPressd: (() {
                  setActive('WorkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${workTimepath}WorkGirl19.png',
                onPressd: (() {
                  setActive('WorkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${workTimepath}WorkGirl20.png',
                onPressd: (() {
                  setActive('WorkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${workTimepath}WorkGirl21.png',
                onPressd: (() {
                  setActive('WorkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${workTimepath}WorkGirl24.png',
                onPressd: (() {
                  setActive('WorkGirl');
                  GoRouter.of(context).pop();
                }),
              ),
            ],
            childrenRoutine: [
              ImageButton(
                imageName: '${whatnowpath}WalkGirl.jpg',
                onPressd: (() {
                  setActive('Walkgirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${whatnowpath}SleepGirl.jpg',
                onPressd: (() {
                  setActive('SleepGirl');
                  GoRouter.of(context).pop();
                }),
              ),
              ImageButton(
                imageName: '${whatnowpath}BreakGirl.jpg',
                onPressd: (() {
                  setActive('BreakGirl');
                  GoRouter.of(context).pop();
                }),
              ),
            ],
            childrenEmotion: [
              ImageButton(
                imageName: '${whatnowpath}BreakGirl.jpg',
                onPressd: (() {
                  setActive('BreakGirl');
                  GoRouter.of(context).pop();
                }),
              ),
            ],
          );
          // return EngageDialog();
        });
  }

  void setActive(String object) {
    ///Activeは最後に実行。
    unityWidgetController.postMessage(
      'ActiveChanger',
      'VanishWaitGirl',
      '',
    );
    unityWidgetController.postMessage(
      'ActiveChanger',
      'VanishWalkGirl',
      '',
    );
    unityWidgetController.postMessage(
      'ActiveChanger',
      'VanishWorkGirl',
      '',
    );
    unityWidgetController.postMessage(
      'ActiveChanger',
      'VanishSleepGirl',
      '',
    );

    ///Active
    unityWidgetController.postMessage(
      'ActiveChanger',
      'Active${object}',
      object,
    );
  }

  void setVanish(String object) {
    unityWidgetController.postMessage(
      'ActiveChanger',
      'Vanish${object}',
      object,
    );
  }

  void onUnitySceneLoaded(SceneLoaded scene) {
    print('Received scene loaded from unity: ${scene.name}');
    print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  }

  void onUnityCreated(controller) {
    controller.resume();
    unityWidgetController = controller;
  }
}
