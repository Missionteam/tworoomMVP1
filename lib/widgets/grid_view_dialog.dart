import 'package:flutter/material.dart';

class GridViewDialog extends StatefulWidget {
  GridViewDialog(
      {Key? key, required this.Screenpadding, required this.children})
      : super(key: key);
  EdgeInsetsGeometry Screenpadding;
  List<Widget> children;

  @override
  State<GridViewDialog> createState() => _GridViewDialogState();
}

class _GridViewDialogState extends State<GridViewDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: widget.Screenpadding,
        child: Container(
          color: Colors.white,
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            padding: EdgeInsets.only(bottom: 30, left: 30, right: 30, top: 50),
            children: widget.children,
          ),
        ),
      ),
    );
  }
}
