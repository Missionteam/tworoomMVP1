import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget_example/models/room_id_model.dart';
import 'package:flutter_unity_widget_example/pages/auth/error_screen.dart';
import 'package:flutter_unity_widget_example/pages/auth/loading_screen.dart';
import 'package:flutter_unity_widget_example/pages/home_page.dart';
import 'package:flutter_unity_widget_example/providers/auth_provider.dart';
import 'package:flutter_unity_widget_example/providers/rooms_provider.dart';

import '../allConstants/all_constants.dart';
import '../pages/auth/sign_in_page.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    ///ここの分岐はauthの方消して良いはずだけど、デバック時に確かめる。
    final authState = ref.watch(authStateProvider);
    return authState.when(
        data: (data) {
          if (data != null) {
            ref.watch(roomsProvider).when(
                data: (data) {
                  final roomId = data.docs[0].id;
                  ref.read(roomIdProvider.notifier).setRoomId(roomId);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                  return;
                },
                error: (e, trace) => ErrorScreen(e, trace),
                loading: () => const LoadingScreen());
            return const HomePage();
          }
          return const SignInPage();
        },
        loading: () => const LoadingScreen(),
        error: (e, trace) => ErrorScreen(e, trace));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Welcome to Smart Talk",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Sizes.dimen_18),
            ),
            Image.asset(
              'assets/images/splash.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Smartest Chat Application",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Sizes.dimen_18),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(
              color: AppColors.lightGrey,
            ),
          ],
        ),
      ),
    );
  }
}
