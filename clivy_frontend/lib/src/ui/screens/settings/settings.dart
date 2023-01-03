import 'package:another_flushbar/flushbar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled_client/src/api/graphql/graphql_api.dart';
import 'package:untitled_client/src/bloc/deleteUserBloc/deleteUserCubit.dart';
import 'package:untitled_client/src/bloc/deleteUserBloc/deleteUserState.dart';
import 'package:untitled_client/src/bloc/signOut/signOutCubit.dart';
import 'package:untitled_client/src/models/currentUser.dart';
import 'package:untitled_client/src/ui/screens/settings/widgets/deleteUserDialog.dart';
import 'dart:math' as math;
import 'package:untitled_client/src/ui/screens/settings/widgets/settingTile.dart';
import 'package:untitled_client/src/ui/screens/user/editProfile.dart';
import 'package:untitled_client/src/utils/customAppBar.dart';
import 'package:uuid/uuid.dart';

class Settings extends StatefulWidget {
  const Settings({ Key? key }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late DeleteUserCubit deleteUserCubit;

  @override
  void initState() {
    deleteUserCubit = BlocProvider.of<DeleteUserCubit>(context);
    deleteUserCubit.stream.listen((state) {
      if (state is DeleteUserErrorState) {
        Future.delayed(Duration(milliseconds: 300), () {
          showFlushbar();
          deleteUserCubit.changeToInit();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).padding.top + 45,
              // color: Colors.green
              child: CustomAppBar(
                statusBar: MediaQuery.of(context).padding.top,
                title: "Settings",
                titleColor: Color(0xff00ff03),
                goBackColor: Colors.grey[700]!,
                key: Key('Settings')
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,//EdgeInsets.symmetric(horizontal: 12), 
                children: [
                  GestureDetector(
                    onTap: () {
                      if (CurrentUser.user != null) {
                        Get.to(EditProfile(
                          user: User$Query$User.fromJson(CurrentUser.user!.toJson()), 
                          key: Key('EditProfile')
                        ));
                      }
                    },
                    child: SettingTile(
                      settingTileText: "Edit Profile",
                      icon: Icon(
                        FluentIcons.person_24_regular,
                        color: Colors.white,
                        size: 28
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<SignOutCubit>(context).signOut();
                    },
                    child: SettingTile(
                      settingTileText: "Log Out",
                      icon: Transform.rotate(
                        angle: 180 * math.pi / 180,
                        child: Icon(
                          EvaIcons.logOutOutline,
                          color: Colors.white,
                          size: 28
                        ),
                      )
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // create a dialog
                      // if (CurrentUser.user != null) {
                      //   UserRepository(client: Client.client!).deleteUser(CurrentUser.userId!);
                      // }
                      // print("aaa");
                      Get.generalDialog(
                        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                        barrierColor: Colors.black.withOpacity(0.3),
                        transitionDuration: Duration(milliseconds: 300),
                        barrierDismissible: true,
                        pageBuilder: (context, anim1, anim2) {

                          return DeleteUserDialog(
                            // commentId: widget.comment.id.toInt(),
                            // isReply: false,
                            key: Key("${Uuid().v4()}")
                          );
                        },
                        transitionBuilder: (context, anim1, anim2, child) {
                          return SlideTransition(
                            position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(new CurvedAnimation(
                              parent: anim1,
                              curve: Curves.decelerate
                            )),
                            child: child,
                          );
                        },
                      );
                    }, 
                    child: SettingTile(
                      settingTileText: "Delete Account",
                      icon: Icon(
                        EvaIcons.trash2Outline,
                        color: Colors.white,
                        size: 28
                      ),
                    ),
                  ),
                  // edit profile
                  // sign out
                  // delete account
                ]
              )
            )
          ],
        )
      )
    );
  }

  void showFlushbar() {
    if (mounted) {
      // deleteUserCubit.changeToInit();
      Flushbar(
        backgroundColor: Color(0xFF303030).withOpacity(0.98),
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        borderRadius: BorderRadius.circular(12),
        flushbarPosition: FlushbarPosition.TOP,
        // blockBackgroundInteraction: false,
        messageText: Container(
          child: Row(
            children: [
              // Container(
              //   height: 25,
              //   width: 25,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Color(0xff00ff03),
              //     border: Border.all(
              //       width: 2, 
              //       color: Color(0xff00ff03) 
              //     )
              //   ),
                Center(
                  child: Icon(
                    EvaIcons.alertTriangleOutline,
                    color: Colors.red,
                  )
                // )
              ),
              SizedBox(
                width: 12
              ),
              Container(
                child: Text(
                  "Failed to delete user",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  )
                )
              )
            ]
          )
        ),
        duration: Duration(seconds: 5),
      )..show(context);
    }
    // deleteUserCubit.changeToInit();
  }
}