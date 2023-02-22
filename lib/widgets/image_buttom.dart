import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget_example/providers/users_provider.dart';

import 'specific/engageButton/stamp_view_dialog.dart';

class ImageButton extends ConsumerWidget {
  ImageButton({
    Key? key,
    required this.imageName,
    required this.onPressd,
  }) : super(key: key);
  final String imageName;
  final void Function()? onPressd;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      elevation: 8.0,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/${imageName}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      onPressed: onPressd,
    );
  }
}

class StampButton extends ConsumerWidget {
  StampButton({
    Key? key,
    required this.imageName,
  }) : super(key: key);
  final String imageName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ImageButton(
        imageName: imageName,
        onPressd: () {
          final CurrentUserDoc = ref.watch(CurrentAppUserDocProvider).value;
          CurrentUserDoc?.reference.update({'stamp': imageName});
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (_) {
                return StampView(
                  stampName: imageName,
                );
              });
        });
  }
}
