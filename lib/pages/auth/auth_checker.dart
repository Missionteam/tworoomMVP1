import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tworoom/pages/auth/sign_in_page.dart';

import '../../providers/auth_provider.dart';
import '../home_page.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  //  Notice here we aren't using stateless/statefull widget. Instead we are using
  //  a custom widget that is a consumer of the state.
  //  So if any data changes in the state, the widget will be updated.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  now the build method takes a new paramaeter ScopeReader.
    //  this object will be used to access the provider.

    //  now the following variable contains an asyncValue so now we can use .when method
    //  to imply the condition
    ///ここの分岐はauthの方消して良いはずだけど、デバック時に確かめる。
    final authState = ref.watch(authStateProvider);
    return authState.when(
        data: (data) {
          if (data != null) {
            return const HomePage();
          }
          return const SignInPage();
        },
        loading: () => const LoadingScreen(),
        error: (e, trace) => ErrorScreen(e, trace));
  }
}
