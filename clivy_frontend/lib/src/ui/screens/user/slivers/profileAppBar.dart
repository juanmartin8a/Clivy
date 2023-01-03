import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';

class ProfileAppBar extends SliverPersistentHeaderDelegate {
  final int userId;
  final User$Query$User? user;
  final bool includeBackButton;
  const ProfileAppBar({
    required this.userId,
    this.user,
    this.includeBackButton = true
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // print(context);
    // print("aaaa $shrinkOffset");
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft, 
            child: Container(
              margin: EdgeInsets.only(left: 52), 
              child: user != null ? Text(
                user!.username,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: user!.username.length <= 25 ? 18 : 18,
                  fontWeight: FontWeight.w700
                )
              ) : Container()
            )
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                // color: Colors.red,
                width: 52,
                child: FloatingActions(
                  icon: EvaIcons.arrowBackOutline,
                  size: 34,
                  key: Key("goBack")
                ),
              ),
            )
          ),
        ],
      )
    );
  }


  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  // @override
  // OverScrollHeaderStretchConfiguration get stretchConfiguration =>
  //   OverScrollHeaderStretchConfiguration(
  //     stretchTriggerOffset: maxExtent,
  //     onStretchTrigger: () async {}
  //   );

  // double get maxShrinkOffset => 200;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

}