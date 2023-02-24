import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
    const backgroundColor = Color.fromARGB(255, 3, 23, 77);
    return Scaffold(
        body: child,
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: backgroundColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.question_answer_outlined),
                label: 'Chat',
                backgroundColor: backgroundColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.import_contacts_rounded),
                label: 'Rooms',
                backgroundColor: Color.fromARGB(255, 180, 35, 35),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.textsms_outlined),
                label: 'MyRoom',
                backgroundColor: backgroundColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Note',
                backgroundColor: backgroundColor,
              ),
            ],
            currentIndex: _calculateSelectedIndex(context),
            backgroundColor: backgroundColor,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: (int idx) => _onItemTapped(idx, context),
            fixedColor: Color.fromARGB(177, 202, 202, 202),
            unselectedItemColor: Color.fromARGB(154, 147, 151, 165),
            showUnselectedLabels: true,
            showSelectedLabels: true,
            unselectedLabelStyle: GoogleFonts.nunito(
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 90, 90, 90),
            ),
            selectedLabelStyle: GoogleFonts.nunito(
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 90, 90, 90),
            ),
            enableFeedback: false,
          ),
        ));
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/Home')) {
      return 0;
    }
    if (location.startsWith('/Chat')) {
      return 1;
    }
    if (location.startsWith('/RoomGrid')) {
      return 2;
    }
    if (location.startsWith('/MyRoom')) {
      return 3;
    }
    if (location.startsWith('/Setting')) {
      return 4;
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
        GoRouter.of(context).go('/RoomGrid');
        break;
      case 3:
        GoRouter.of(context).go('/MyRoom');
        break;
      case 4:
        GoRouter.of(context).go('/Setting');
        break;
    }
  }
}
