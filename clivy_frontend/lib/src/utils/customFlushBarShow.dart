import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart' as route;
import 'package:flutter/material.dart';

Future showFlushbar(BuildContext context, Flushbar instance) {
  final _route = route.showFlushbar(
    context: context,
    flushbar: instance,
  );

  return Navigator.of(context, rootNavigator: true).push(_route);
}