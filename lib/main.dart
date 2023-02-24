import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget_example/pages/auth/auth_checker.dart';
import 'package:flutter_unity_widget_example/pages/chat_page.dart';
import 'package:flutter_unity_widget_example/pages/chat_room_page.dart';
import 'package:flutter_unity_widget_example/pages/home_page.dart';
import 'package:flutter_unity_widget_example/pages/my_page.dart';

import 'package:flutter_unity_widget_example/pages/myroom_page.dart';
import 'package:flutter_unity_widget_example/pages/room_grid_page.dart';
import 'package:flutter_unity_widget_example/pages/room_page2.dart';
import 'package:flutter_unity_widget_example/screens/no_interaction_screen.dart';
import 'package:flutter_unity_widget_example/screens/orientation_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_unity_widget_example/widgets/fundomental/BtmNavigation.dart';
import 'package:go_router/go_router.dart';

import 'firebase_options.dart';
import 'menu_screen.dart';
import 'screens/api_screen.dart';
import 'screens/loader_screen.dart';
import 'screens/simple_screen.dart';

//      home: const SignInPage(),
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

Future<void> main() async {
  // main 関数でも async が使えます
  WidgetsFlutterBinding.ensureInitialized(); // runApp 前に何かを実行したいときはこれが必要です。
  await Firebase.initializeApp(
    // これが Firebase の初期化処理です。
    options: DefaultFirebaseOptions.android,
  );
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/Auth_checker',
    routes: <RouteBase>[
      /// Application shell
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: <RouteBase>[
          /// The first screen to display in the bottom navigation bar.
          GoRoute(
            path: '/Auth_checker',
            pageBuilder: (BuildContext context, GoRouterState state) =>
                NoTransitionPage(
              child: const AuthChecker(),
            ),
          ),

          /// Displayed when the second item in the the bottom navigation bar is
          /// selected.
          GoRoute(
            path: '/Home',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: const HomePage());
            },
          ),

          /// The third screen to display in the bottom navigation bar.
          GoRoute(
            path: '/Chat',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: ChatPage());
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'Rooms',
                builder: (BuildContext context, GoRouterState state) {
                  return const RoomPage();
                },
              ),
              // GoRoute(
              //     path: 'Reply/:post',
              //     builder: ((context, state) {
              //       return ReplyPage(post: state.params['post']);
              //     })),
            ],
          ),
          GoRoute(
            path: '/RoomGrid',
            pageBuilder: (BuildContext context, GoRouterState state) {
              return NoTransitionPage(child: RoomGridPage());
            },
            routes: <RouteBase>[
              // The details screen to display stacked on the inner Navigator.
              // This will cover screen A but not the application shell.
              GoRoute(
                path: 'Chat',
                builder: (BuildContext context, GoRouterState state) {
                  return ChatRoomPage();
                },
              ),
              GoRoute(
                path: 'AddRoom',
                builder: (BuildContext context, GoRouterState state) {
                  return RoomPage();
                },
              ),
            ],
          ),
          GoRoute(
            path: '/MyRoom',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: MyRoomPage());
            },
          ),
          GoRoute(
            path: '/Setting',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: ProfilePage());
            },
          )
        ],
      ),
    ],
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(),
      // home: const SignInPage(),
      // home: const AuthChecker(),
      routerConfig: _router,
      // routes: <String, WidgetBuilder>{
      //   '/home': (BuildContext context) => new MainPage(),
      //   '/testPage': (BuildContext context) => new TestPage()
      // },
    );

    //   元々のAuth＿cheker
    //   if (FirebaseAuth.instance.currentUser == null) {
    //    // 未ログイン
    //    return MaterialApp(
    //      theme: ThemeData(),
    //      home: const SignInPage(),
    //    );
    //  } else {
    //    // ログイン中
    //    return MaterialApp(
    //      theme: ThemeData(),
    //      home: const MainPage(),
    //    );
    //  }
  }
}

class MyApp2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Unity Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MenuScreen(),
        '/simple': (context) => SimpleScreen(),
        '/loader': (context) => LoaderScreen(),
        '/orientation': (context) => OrientationScreen(),
        '/api': (context) => ApiScreen(),
        '/none': (context) => NoInteractionScreen(),
      },
    );
  }
}
