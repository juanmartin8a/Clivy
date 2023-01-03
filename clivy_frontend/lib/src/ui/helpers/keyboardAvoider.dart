import 'package:flutter/material.dart';
import 'dart:ui';

/// Wraps the [child] in a [AnimatedContainer] that adjusts its bottom [padding] to accommodate the on-screen keyboard.
/// Unlike a [Scaffold], it only insets by the actual amount obscured by the keyboard.
/// If [autoScroll] is true and the [child] contains a focused widget such as a [TextField],
/// automatically scrolls so that it is just visible above the keyboard, plus any additional [focusPadding].
class KeyboardAvoider extends StatefulWidget {
  /// The child to embed. If the [child] is not a [ScrollView], it is automatically embedded in a [SingleChildScrollView].
  /// If the [child] is a [ScrollView], it must have a [ScrollController].
  final Widget child;

  /// Duration of the resize animation. Defaults to 100ms. To disable, set to [Duration.zero].
  final Duration duration;

  /// Animation curve. Defaults to [easeOut]
  final Curve curve;

  /// Whether to auto-scroll to the focused widget after the keyboard appears. Defaults to false.
  /// Could be expensive because it searches all the child objects in this widget's render tree.
  final bool autoScroll;

  /// Space to put between the focused widget and the top of the keyboard. Defaults to 12.
  /// Useful in case the focused widget is inside a parent widget that you also want to be visible.
  final double focusPadding;

  KeyboardAvoider({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.easeOut,
    this.autoScroll = false,
    this.focusPadding = 12.0,
  })  : assert(child is ScrollView ? child.controller != null : true),
        super(key: key);

  @override
  _KeyboardAvoiderState createState() => _KeyboardAvoiderState();
}

class _KeyboardAvoiderState extends State<KeyboardAvoider> with WidgetsBindingObserver {
  double _overlap = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: _overlap),
      child: widget.child
    );
  }

  /// WidgetsBindingObserver
  @override
  void didChangeMetrics() {
    //Need to wait a frame to get the new size
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _resize();
    });
  }

  void _resize() {
    final renderObject = context.findRenderObject();
    final renderBox = renderObject as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final widgetRect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      renderBox.size.width,
      renderBox.size.height,
    );
    final keyboardTopPixels = window.physicalSize.height - window.viewInsets.bottom;
    final keyboardTopPoints = keyboardTopPixels / window.devicePixelRatio;
    final overlap = widgetRect.bottom - keyboardTopPoints;
    if (overlap >= 0) {
      print('a');
      setState(() {
        _overlap = overlap;
      });
    }
  }
}