import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/ui/screens/discover/discover.dart';
import 'package:untitled_client/src/ui/screens/home/widgets/floatingActions.dart';
import 'package:untitled_client/src/ui/screens/settings/settings.dart';

import 'homeAppBarTitle.dart';

class HomeAppBar extends StatefulWidget {
  final double statusBar;
  const HomeAppBar({ 
    required this.statusBar,
    required Key key 
  }) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {

  // SignOutCubit? _signOutCubit;

  void initState() {
    super.initState();
    // _signOutCubit = BlocProvider.of<SignOutCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      // margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
      color: Colors.black,
        // border: Border(
        //   bottom: BorderSide(width: 0.8, color: Colors.grey[850]!)
        // )
      ), 
      child: Container(
        margin: EdgeInsets.only(top: widget.statusBar),
        // color: Colors.blue,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeAppBarTitle(username: CurrentUser.user!.username),
            Container(
              margin: EdgeInsets.only(right: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(
                  //       CreatePost()
                  //     );
                  //   },
                  //   child: FloatingActions(
                  //     size: 32,
                  //     icon: EvaIcons.plusOutline,
                  //     key: Key("createAction")
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Search(
                          statusBarHeight: MediaQuery.of(context).padding.top,
                        ),
                        isScrollControlled: true
                      );
                    },
                    child: FloatingActions(
                      size: 34,
                      icon: EvaIcons.searchOutline,
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      key: Key("searchAction")
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // if (_signOutCubit != null) {
                      //   _signOutCubit!.signOut();
                      // }
                      Get.to(Settings());
                    },
                    child: FloatingActions(
                      size: 34,
                      icon: FluentIcons.more_vertical_24_regular,
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      key: Key("settingsAction")
                    ),  
                  ),
                ]
              )
            )
          ],
        ),
      )
    );
  }
}