import 'package:flutter/material.dart';

class FloatingActions extends StatelessWidget {
  final double size;
  final IconData icon;
  final EdgeInsetsGeometry padding;
  final Color color;
  const FloatingActions({ 
    required this.size,
    required this.icon,
    this.padding = const EdgeInsets.only(left: 8, right: 8),
    this.color = Colors.white,
    required Key key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      padding: padding,
      child: Center(
        child: Icon(
          icon,
          size: size,
          color: color,
        ),
      )
    );
  }
}