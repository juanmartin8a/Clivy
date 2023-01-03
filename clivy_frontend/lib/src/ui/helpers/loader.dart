import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double radius;
  const Loader({
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.radius = 11,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: padding,
      child: Center(
        child: Theme(
          data: ThemeData(cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark)),
          child: CupertinoActivityIndicator(
            radius: radius,
          )
        )
        // CupertinoActivityIndicator(
        //   radius: 15, 
        // )
      )
    );
  }
}