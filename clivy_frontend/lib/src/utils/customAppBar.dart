import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';

class CustomAppBar extends StatelessWidget {
  final double statusBar;
  final String? title;
  final Widget? actionsWidget;
  final bool useBack;
  final Color titleColor;
  final Color goBackColor;
  const CustomAppBar({ 
    required this.statusBar,
    this.useBack = true,
    this.title,
    this.actionsWidget,
    this.titleColor = Colors.white,
    this.goBackColor = Colors.white,
    required Key key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: statusBar),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (useBack) 
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: FloatingActions(
                icon: EvaIcons.arrowBackOutline,
                size: 34,
                color: goBackColor,
                key: Key("goBack")
              )
            ),
          ),
          Spacer(),
          title != null ? Container(
            margin: EdgeInsets.only(right: 16 + 34),
            child: Text(
              title!,
              style: TextStyle(
                color: titleColor,
                fontSize: title!.length <= 25 ? 18 : 18,
                fontWeight: FontWeight.w700,
                // height: 1
              )
            )
          ) : Container(),
          Spacer(),
          // Container(width: 16 + 34),
          actionsWidget ?? Container()
        ]
      )
    );
  }
}