import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final Widget icon;
  final String settingTileText;
  const SettingTile({ 
    required this.icon,
    required this.settingTileText,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 12), 
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: icon
          ),
          SizedBox(width: 12),
          Container(
            child: Text(
              settingTileText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1
              )
            ),
          ),
          Spacer(),
          Container(
            child: Icon(
              CupertinoIcons.chevron_forward,
              color: Colors.grey[600],
              size: 20
            )
          )
        ],
      )
    );
  }
}