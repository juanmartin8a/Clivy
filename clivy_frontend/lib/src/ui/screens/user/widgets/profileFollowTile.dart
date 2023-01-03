import 'package:flutter/material.dart';

class ProfileFollowTile extends StatelessWidget {
  final String value;
  final String name;
  const ProfileFollowTile({ 
    required this.value,
    required this.name,
    required Key key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                // height: 1,
              )
            )
          ),
          // SizedBox(
          //   height: 1
          // ),
          Container(
            child: Text(
              name,
              style: TextStyle(
                color: Colors.grey[100],
                fontSize: 14,
                fontWeight: FontWeight.w500,
                // height: 1
              )
            )
          )
        ],
      ),
    );
  }
}