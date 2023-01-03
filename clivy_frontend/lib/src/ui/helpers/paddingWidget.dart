import 'package:flutter/material.dart';

class SystemPadding extends StatefulWidget {
  final Widget child;
  SystemPadding({
    required this.child,
    Key? key, 
  }) : super(key: key);
  @override
  _SystemPaddingState createState() => _SystemPaddingState();
}

class _SystemPaddingState extends State<SystemPadding> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedSize(
      vsync: this,
      duration: Duration(milliseconds: 300),
      child: Container(
        padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
          // duration: const Duration(milliseconds: 300),
          child: widget.child
      )
    );
  }
}