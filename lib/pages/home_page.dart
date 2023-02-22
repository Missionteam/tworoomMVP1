import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:flutter_unity_widget_example/providers/users_provider.dart';

import '../widgets/specific/engageButton/engage_dialog.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  late UnityWidgetController _unityWidgetController;

  @override
  void dispose() {
    _unityWidgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: Stack(children: <Widget>[
          UnityWidget(
            onUnityCreated: onUnityCreated,
            fullscreen: false,
          ),
          Positioned(
              left: 30,
              top: 170,
              width: 100,
              child: GestureDetector(
                child: Image.asset('images/EngageBtn.png'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return EngageDialog();
                      });
                },
              )),
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
    );
  }

  void onUnitySceneLoaded(SceneLoaded scene) {
    print('Received scene loaded from unity: ${scene.name}');
    print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  }

  void onUnityCreated(controller) {
    controller.resume();
    _unityWidgetController = controller;
  }
}
