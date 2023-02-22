import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: 'Note',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        elevation: 0,
        onTap: (int idx) => _onItemTapped(idx, context),
        fixedColor: Color.fromARGB(255, 151, 140, 125),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/Home')) {
      return 0;
    }
    if (location.startsWith('/Chat')) {
      return 1;
    }
    if (location.startsWith('/MyRoom')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/Home');
        break;
      case 1:
        GoRouter.of(context).go('/Chat');
        break;
      case 2:
        GoRouter.of(context).go('/MyRoom');
        break;
    }
  }
}
